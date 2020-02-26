Return-Path: <SRS0=LW4I=4O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B69EC4BA09
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 01:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5758F21927
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 01:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYGfWO0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgBZBWk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:22:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48331 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729403AbgBZBWk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 20:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582680158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RSQ0PjdkVdqy+9onXtWZa6UW+aTr60PWh9cpfDKp4jg=;
        b=SYGfWO0U/hg/UkCS9sYfxlfsI+Mi6F8lzuKToh4EzrY5w3HyOUKn7ril3OJJWHx9oFJFPs
        R0pF2bElAWlvWVNcwphBfE4fR/EcN05zP0WhChHqM9wC5jbAexcgn9mGKqc1QujX2N3qLf
        h1A8fEcO2TXkOuk2Ps/3wYO1gZie+2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-LfTAgoYDMs6IinmnI2kATQ-1; Tue, 25 Feb 2020 20:22:36 -0500
X-MC-Unique: LfTAgoYDMs6IinmnI2kATQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A618BDBA5;
        Wed, 26 Feb 2020 01:22:35 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D8D15C28C;
        Wed, 26 Feb 2020 01:22:32 +0000 (UTC)
Date:   Tue, 25 Feb 2020 20:22:31 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: dm integrity: reinitialize __bi_remaining when reusing bio
Message-ID: <20200226012231.GA12308@redhat.com>
References: <20200225170744.10485-1-dg@emlix.com>
 <20200225191222.GA3908@infradead.org>
 <a932a297-266e-4dee-f030-40ecbc9899ca@emlix.com>
 <20200225220254.GA13356@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200225220254.GA13356@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 25 2020 at  5:02pm -0500,
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Feb 25, 2020 at 08:54:07PM +0100, Daniel Gl=F6ckner wrote:
> > bio_reset will reset too many fields. As you can see in the context o=
f
> > the diff, dm-integrity expects f.ex. the values modified by bio_advan=
ce
> > to stay intact and the transfer should of course use the same disk an=
d
> > operation.
> >=20
> > How about doing the atomic_set in bio_remaining_done (in block/bio.c)
> > where the BIO_CHAIN flag is cleared once __bi_remaining hits zero?
> > Or is requeuing a bio without bio_reset really a no-go? In that case =
a
> > one-liner won't do...
>
> That tends to add a overhead to the fast path for a rather exotic
> case.  I'm having a bit of a hard time understanding the dm-integrity
> code due to it's annoyingly obsfucated code, but it seems like it
> tries to submit a bio again after it came out of a ->end_io handler.

Yeah, the dm-integrity code has always been complex and it has only
gotten moreso.  I'm struggling with it too.

This case that Daniel has seen a BUG_ON with is when there is a need to
finish a partially completed bio (as reflected by the per-bio-data's
internal accounting managed by dm-integrity).

> That might have some other problems, but if we only want to paper
> over the remaining count a isngle call to bio_inc_remaining might be al=
l
> you need.

bio_inc_remaining() is really meant to be paired with bio_chain().  They
are pretty tightly coupled these days.  We removed __bio_inc_remaining()
once we weened all (ab)users many releases ago.  Definitely don't want
an open-coded equivalent buried in an obscure dm-integrity usecase.

Could be bio_split() + generic_make_request() recursion is a way
forward -- but that'd likely require some extra work in dm-integrity.
All the additional code in dm_integrity_map_continue() makes me think I
could easily be missing something.

Mikulas, if you could look closer at this issue and see what your best
suggestion would be that'd be appreciated.

Thanks,
Mike

