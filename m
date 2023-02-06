Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D6AC05027
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 07:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBFHdK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 02:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBFHdK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 02:33:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F16D30EA
        for <linux-block@vger.kernel.org>; Sun,  5 Feb 2023 23:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675668726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2P1z3oXYGbD6CfZ/1PxMnti6t09JY8eEedLnkW8eDLQ=;
        b=Dcs/tbFMWkAqLugG3ykZZVDG42KATCou1BBV/InzF2uZOHy9MLjQtCJ8ulEzJqeGl1dGC5
        qrTDbs4MOFV6M3JTtBr21WGXfZqbuQRKksPLgWwrW2N0QUyRHqOpfk0Kz4qFZnH/ulD+Ms
        +xFVfxFLzbcz8EcpLvbe2i6ScDLxO2w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-605-QCRdMHhMOXCwfsr1JxJzcA-1; Mon, 06 Feb 2023 02:32:04 -0500
X-MC-Unique: QCRdMHhMOXCwfsr1JxJzcA-1
Received: by mail-pj1-f70.google.com with SMTP id k15-20020a17090a590f00b002300fe6b09dso8254687pji.0
        for <linux-block@vger.kernel.org>; Sun, 05 Feb 2023 23:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2P1z3oXYGbD6CfZ/1PxMnti6t09JY8eEedLnkW8eDLQ=;
        b=N1lhBRrqdtyUKDTxA1O3Usc4cYPrSKfhgTVxrPbjrLRGNW/a3fWx5M1iRYEdIqKMIu
         yyW+uWkIVwTv8KatXyEjZRg7+wUHY/xycF/G5VvqiE9pHznpUULfIJSG9bkeHigBx+XB
         EbGu8pUDQc1q+OQEr+OgVzhCYQ0K5cn2yLK5GggozLeYH6xQoAzs63O7a6l6lSIQ+UPH
         UHKF5Zk58fhKBHiqsYVstwUOZ9waG3sV/aEKcgg/6+cKvNWp1e0n2zI4PZ7bllUer8xY
         rSAstBzVf7MXaAKIRPzF+6izeok+k9VzbAjkBjDDTUWpMTLB0yNIUUn3/+jcSMrLziJl
         Tckg==
X-Gm-Message-State: AO0yUKXJBot68aPYDWkJ72BGtuNPIIjkHWHIF68bcT1oqRbS4G3FSSJs
        mZM5iDKWOjHeByNe813+d3HTfXT7Ye1oho3iSRxkKb5IPa9CAWGSzJES1tiqUyiVe5ZhicZfUSi
        Uk2jZmL3DKNwzjCt57j1e496+YLh+9f+Q3DO/rBA=
X-Received: by 2002:a63:5255:0:b0:4de:7e96:17d0 with SMTP id s21-20020a635255000000b004de7e9617d0mr3001783pgl.84.1675668722554;
        Sun, 05 Feb 2023 23:32:02 -0800 (PST)
X-Google-Smtp-Source: AK7set+e1eY+H9RNK/Hpj9rMw9KsEy+HGJO09Hfqk9KReu8F4+Vbb8tYRq2VY1xD3fk263XXR7/GneFgooCEp1BDUeg=
X-Received: by 2002:a63:5255:0:b0:4de:7e96:17d0 with SMTP id
 s21-20020a635255000000b004de7e9617d0mr3001779pgl.84.1675668722328; Sun, 05
 Feb 2023 23:32:02 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs-ZvyXKU9iAVKSkh2NfN5238rh-OaU8_uDBHVFtJb2ASQ@mail.gmail.com>
 <20230206062037.GA9567@lst.de> <CAHj4cs_HT+iqoPkRcAFr8A4o5C3TzDE6h2fA-ZUbhiek7-MwnA@mail.gmail.com>
 <20230206065343.GA9951@lst.de>
In-Reply-To: <20230206065343.GA9951@lst.de>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 6 Feb 2023 15:31:50 +0800
Message-ID: <CAHj4cs-C1f2FH1WaceHm_DeWo-cgU7K7O=ZLyZqU7_wE+YzK5Q@mail.gmail.com>
Subject: Re: [bug report] RIP: 0010:blkg_free+0xa/0xe0 observed on latest linux-block/for-next
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 6, 2023 at 2:53 PM Christoph Hellwig <hch@lst.de> wrote:
>
> This should fix it:

Thanks for the quick fix, will try to reproduce it on the reproduced
server and retest it.

>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 8faeca6022bea0..c46778d1f3c27d 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -383,7 +383,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
>  err_put_css:
>         css_put(&blkcg->css);
>  err_free_blkg:
> -       blkg_free(new_blkg);
> +       if (new_blkg)
> +               blkg_free(new_blkg);
>         return ERR_PTR(ret);
>  }
>
>


-- 
Best Regards,
  Yi Zhang

