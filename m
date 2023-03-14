Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25ABC05027
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 19:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCNTv0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 15:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjCNTvZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 15:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF282CFC5
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 12:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678823432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3M5M7uIlC8hyhww3unkjtp+hcWjh4Vt7Gzo5dt9yCXk=;
        b=PlIDzNitNYULMVGa06UyDFNQ3ffzuSNqXlVUxzivD2gJlNfbm/uhkN9jkO0EqgLbO5Pdmm
        bQxgOyyavaFWj9Og5oIt2qRg2/y60ZNiPG0AA5K5qrb4CuEwheWwkpEMJmVUMg+252Z/hT
        95fit1b2GIywqZtOLFsz1VzrUsNzpWo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-3pv0nfEjMBCC45D0Ch-0fA-1; Tue, 14 Mar 2023 15:50:26 -0400
X-MC-Unique: 3pv0nfEjMBCC45D0Ch-0fA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAB8938123A8;
        Tue, 14 Mar 2023 19:50:25 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4AB540C6E67;
        Tue, 14 Mar 2023 19:50:24 +0000 (UTC)
Date:   Tue, 14 Mar 2023 14:50:23 -0500
From:   Eric Blake <eblake@redhat.com>
To:     Nir Soffer <nsoffer@redhat.com>
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] uapi nbd: add cookie alias to handle
Message-ID: <20230314195023.bsey5bfq2atz7d66@redhat.com>
References: <20230310201525.2615385-1-eblake@redhat.com>
 <20230310201525.2615385-3-eblake@redhat.com>
 <CAMRbyysDE+v_D6Q3tCf_+86T0V57UE4Emw6zc_4vnUu0Yau23A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRbyysDE+v_D6Q3tCf_+86T0V57UE4Emw6zc_4vnUu0Yau23A@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 11, 2023 at 02:30:39PM +0200, Nir Soffer wrote:
> On Fri, Mar 10, 2023 at 10:16 PM Eric Blake <eblake@redhat.com> wrote:
> >
> > The uapi <linux/nbd.h> header declares a 'char handle[8]' per request;
> > which is overloaded in English (are you referring to "handle" the
> > verb, such as handling a signal or writing a callback handler, or
> > "handle" the noun, the value used in a lookup table to correlate a
> > response back to the request).  Many client-side NBD implementations
> > (both servers and clients) have instead used 'u64 cookie' or similar,
> > as it is easier to directly assign an integer than to futz around with
> > memcpy.  In fact, upstream documentation is now encouraging this shift
> > in terminology: https://lists.debian.org/nbd/2023/03/msg00031.html
> >
> > Accomplish this by use of an anonymous union to provide the alias for
> > anyone getting the definition from the uapi; this does not break
> > existing clients, while exposing the nicer name for those who prefer
> > it.  Note that block/nbd.c still uses the term handle (in fact, it
> > actually combines a 32-bit cookie and a 32-bit tag into the 64-bit
> > handle), but that internal usage is not changed the public uapi, since
> > no compliant NBD server has any reason to inspect or alter the 64
> > bits sent over the socket.
> >
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >  include/uapi/linux/nbd.h | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/nbd.h b/include/uapi/linux/nbd.h
> > index 8797387caaf7..f58f2043f62e 100644
> > --- a/include/uapi/linux/nbd.h
> > +++ b/include/uapi/linux/nbd.h
> > @@ -81,7 +81,10 @@ enum {
> >  struct nbd_request {
> >         __be32 magic;   /* NBD_REQUEST_MAGIC    */
> >         __be32 type;    /* See NBD_CMD_*        */
> > -       char handle[8];
> > +       union {
> > +               char handle[8];
> > +               __be64 cookie;
> > +       };
> >         __be64 from;
> >         __be32 len;
> >  } __attribute__((packed));
> > @@ -93,6 +96,9 @@ struct nbd_request {
> >  struct nbd_reply {
> >         __be32 magic;           /* NBD_REPLY_MAGIC      */
> >         __be32 error;           /* 0 = ok, else error   */
> > -       char handle[8];         /* handle you got from request  */
> > +       union {
> > +               char handle[8]; /* handle you got from request  */
> > +               __be64 cookie;
> 
> Should we document like this?
> 
>     union {
>         __be64 cookie; /* cookie you got from request */
>         char handle[8]; /* older name */
> 
> I think we want future code to use the new term.

Sure, swapping the order to favor the preferred name first makes sense.

I'm still not sure on whether cookie should be u64 or __be64 (it's
opaque, so endianness over the wire doesn't matter; and previous code
was using memcpy() onto char[8] which may behave differently depending
on machine endianness).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

