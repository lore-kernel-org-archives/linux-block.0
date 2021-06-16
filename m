Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6DEC48BE6
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 10:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9BC6128B
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 10:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhFPK4g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 06:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29857 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232267AbhFPK4f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 06:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623840869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6U5uz84VeO5sSCRxGVRQ9TQPf0fN7oSmU6mjkdDVK2w=;
        b=D0SgtZtL8p/QRGiDk9BqpiZeTeJjDdj1Z7a3MzdwwRc921J8CPpl/e6z9E2IGS4tABk/Fp
        gxXwlIpSLFusrDPB791yNjdWEE4+rYsHHzHELSlQZnMPj7aPfhnVEiJGabJDCaeg2alHLh
        R5BmaRpDVS+oPlFqyMkY77MvdZ3T5zw=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-0zisAsckNeahDl1-JsLZ2g-1; Wed, 16 Jun 2021 06:54:28 -0400
X-MC-Unique: 0zisAsckNeahDl1-JsLZ2g-1
Received: by mail-ot1-f71.google.com with SMTP id e14-20020a0568301f2eb0290405cba3beedso1308862oth.13
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 03:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6U5uz84VeO5sSCRxGVRQ9TQPf0fN7oSmU6mjkdDVK2w=;
        b=PDJ+jpmQCDzlJ9lMG19qw8fhcoqsuS7oVCU0Q7SRy5T9qc1thJFbk3auC2PMAvP8pl
         Z+rNCQLIO44vCKnufhSwFVBeIYls1IJVxa/KHQPFdFSenuwtO93FliyiJar5oC7oLtJI
         I0FrAEzVSejUw5jKAhN7KgujCj6Xn0jr3bI3NMS1CYQ+G9mUznF+Wze8utqZt0MqP16a
         OVLGYnWaYs0aA+ljn8aMybaXui5GCHmvuSW572pvZO8ErSeDRgUEZ/FjdyuY611tb8Lw
         8OvPjHtN0FySariZkTD+XoZeIUE0RG0QwM6G1yXalTzqqXuHzg9MxcySHM02HdfoiWSo
         EsoA==
X-Gm-Message-State: AOAM530aqF6koeV0LTYoGSNFbyDrnvsfOBDV8WpTKAnMPdybS4mOkCwe
        8sZdUlz9btMS6Ra5PWAXV9iqqJ+9k4zPUUne6H8UXUAOCJIdiPQMEEPdLIexPHixLDzVKlD8K0/
        nbC69rUa/6YWa4y7yFjXOB5uAxvsrVC3wWHJlNuQ=
X-Received: by 2002:aca:d805:: with SMTP id p5mr2788674oig.60.1623840867482;
        Wed, 16 Jun 2021 03:54:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZhO/xDLvkelH4clCIKA5sHIOS+b2ET1KhJ8m0fEQZttn1JKRrIxmPZRrvUvwKMHRSTQnAV4pPWrSdKm+3ojE=
X-Received: by 2002:aca:d805:: with SMTP id p5mr2788660oig.60.1623840867270;
 Wed, 16 Jun 2021 03:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <cki.E3198A727A.0A5WS1XUPX@redhat.com> <CA+QYu4qjrzyjM_zgJ8SSZ-zsodcK=uk8xToAVR3+kmOdNZfgZQ@mail.gmail.com>
 <20210615115243.GA12378@lst.de> <CAFj5m9Kp4T1R_RB1B4W3dvjU5M17wWCZ6OVbvYWjXLcGvab6=A@mail.gmail.com>
 <20210615160027.GA31772@lst.de>
In-Reply-To: <20210615160027.GA31772@lst.de>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Wed, 16 Jun 2021 12:54:16 +0200
Message-ID: <CA+QYu4pzbotv4Sj=jMKaUHouVURgMX9TrdrZUwGa7mx7Q5jsAw@mail.gmail.com>
Subject: Re: ? PANICKED: Test report for kernel 5.13.0-rc3 (block, 30ec225a)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        skt-results-master@redhat.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Fine Fan <ffan@redhat.com>,
        Jeff Bastian <jbastian@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 15, 2021 at 6:01 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jun 15, 2021 at 09:58:03PM +0800, Ming Lei wrote:
> > On Tue, Jun 15, 2021 at 7:52 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Mon, Jun 14, 2021 at 02:40:58PM +0200, Bruno Goncalves wrote:
> > > > Hi,
> > > >
> > > > We've noticed a kernel oops during the stress-ng test on aarch64 more log
> > > > details on [1]. Christoph, do you think this could be related to the recent
> > > > blk_cleanup_disk changes [2]?
> > >
> > > It doesn't really look very related.  Any chance you could bisect it?
> >
> > It should be the wrong order between freeing tagset and cleanup disk:
> >
> > static void loop_remove(struct loop_device *lo)
> > {
> >         ...
> >         blk_mq_free_tag_set(&lo->tag_set);
> >         blk_cleanup_disk(lo->lo_disk);
> >         ...
> >  }
>
> Indeed.  Something like this should fix the issue:
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 9a48b3f9a15c..e0c4de392eab 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2172,8 +2172,8 @@ static int loop_add(struct loop_device **l, int i)
>  static void loop_remove(struct loop_device *lo)
>  {
>         del_gendisk(lo->lo_disk);
> -       blk_mq_free_tag_set(&lo->tag_set);
>         blk_cleanup_disk(lo->lo_disk);
> +       blk_mq_free_tag_set(&lo->tag_set);
>         mutex_destroy(&lo->lo_mutex);
>         kfree(lo);
>  }
>
Thank you Christoph and Ming,

I've tested the patch and the panic is gone. I still hit some kernel
oops, but that doesn't seem related to any block change.

Bruno

