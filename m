Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24013C10F0E
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 02:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFF120656
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 02:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igGEhHvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfDPCYN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:24:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43123 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfDPCYM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 22:24:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id v32so21614122qtc.10;
        Mon, 15 Apr 2019 19:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LlTDpZuIFjJuPEuqIHHIv28pYged3rMJDHnhIBi9hTo=;
        b=igGEhHvR7MJdsRxBMXLI3mZ3XmsAXXT1eiEMHpzUxAqq/evYvm4VyWflG6XueKQzAw
         TmB3OxhvJIyycr4WRRuNhclWVTw2zS+83fE4La+iw9gyZtO77XzsTMeICxfRmufhSOU9
         gydbAEq9fGMG7cvYp3KGAwIQN7NGBT6N0cIrRrTwdi7/7lykTSOVw6Ro9OBnlu/RHFJE
         MzLgrf5CPTnJxVnQ0YWdC9WZ41yZiUJnwgDiPTOvQ9q15d6KlcAWzAmiXkfTsl8HXD2/
         //Nxz4CLycF3lh1seTa40sXfYHNYpf8FS+3eI4lYzWe/s1UPnciu+fjwDNfTukQOl1Db
         dR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LlTDpZuIFjJuPEuqIHHIv28pYged3rMJDHnhIBi9hTo=;
        b=gjjtyaGi/Fj7ioWfLG4ynP4erh1Dk3h+lR8B4D5AJcQU1KNYEBz/NVNaPGipBwcyXX
         LlGjQgsMSDMNUoP6UiW9UY6xuOV2swDG0O8Sr1kjv4DgMQzrXyXcPsoKidhSgB7rq8fU
         g5z9kbiu8B0fX7bXFKmu8JQj7Qz2/Aaom2aTTZIbet6YWlvsZxYNA0JHnBdZj7LW/LSS
         stv0r/+m6gI7ppQfiIHjMljCyyCT6WIaaDJgwNDqpf3QhBEZj5dCSQQu55PLY8EJxFje
         K3Cq4396W3GJlXvU6mUGZTeFswc2liFbgaDDrYngVtScxi9GDJIB2JO400pHmGGSXqm1
         FJow==
X-Gm-Message-State: APjAAAVw9eEegfGABdhnOrIZSQQr1NgHE5bRycyl/YYLzbPzoMmmD/7B
        X9BWfgquSitS4GzAEWBBpA0sCxmFMnI=
X-Google-Smtp-Source: APXvYqx/v1FTGjwJVx8XTbRt+L9HNwoLa1wX/QlBcoLg/mvjiZodgUFrFKoPzlbbXURqiKRgYNlLwQ==
X-Received: by 2002:ac8:372e:: with SMTP id o43mr63440214qtb.74.1555381450962;
        Mon, 15 Apr 2019 19:24:10 -0700 (PDT)
Received: from laptop (189.26.177.132.dynamic.adsl.gvt.net.br. [189.26.177.132])
        by smtp.gmail.com with ESMTPSA id h186sm32147647qke.45.2019.04.15.19.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 19:24:09 -0700 (PDT)
Date:   Mon, 15 Apr 2019 23:23:55 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/3] blk-mq.c: Rework documention of blk_mq_init_sq_queue
 function
Message-ID: <20190416022315.GA153476@laptop>
References: <20190414031055.26350-1-marcos.souza.org@gmail.com>
 <20190414031055.26350-2-marcos.souza.org@gmail.com>
 <SN6PR04MB4527248A7EC22784AE6C0836862A0@SN6PR04MB4527.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB4527248A7EC22784AE6C0836862A0@SN6PR04MB4527.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 14, 2019 at 09:02:13PM +0000, Chaitanya Kulkarni wrote:
> On 4/13/19 8:11 PM, Marcos Paulo de Souza wrote:
> > Describing better what the function does, and what the arguments are
> > meant for.
> > 
> > Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> > ---
> >   block/blk-mq.c | 17 ++++++++++++++---
> >   1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 4a8277a54c03..fd0bf89b8a73 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2675,9 +2675,20 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
> >   }
> >   EXPORT_SYMBOL(blk_mq_init_queue);
> >   
> > -/*
> > - * Helper for setting up a queue with mq ops, given queue depth, and
> > - * the passed in mq ops flags.
> > +/**
> Is following line beyond 80 columns ?

Actually it hit the limit of 80 columns.

> > + * blk_mq_init_sq_queue - Create a new request queue with a SQ queue and tag set
> It will be great if we describe what SQ in the above line, otherwise we 
> stating just obvious here.

You're right, I will change the "SQ" for "only one hw_queue (SQ)", to describe
what is the SQ.

> > + * @set: tag set to be associated by the newly created request queue
> > + * @ops: operations to be associated with @set
> > + * @queue_depth: number of tags of @set
> > + * @set_flags: flags of @set
> > + *
> > + * Description:
> > + * @set is initialized using @ops, @queue_depth, @set_flags, and using only one
> > + * hw_queue (SQ). Later on blk_mq_alloc_tag_set() is called to validate and/or
> > + * adjust values of the tag set. blk_mq_init_queue() is called passing @set as
> > + * argument, returning a new request queue with @set associated.
> > + *
> > + * Returns the newly created request queue on success, or ERR_PTR() on failure.
> >    */
> >   struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
> >   					   const struct blk_mq_ops *ops,
> > 
> 

-- 
Thanks,
Marcos
