Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F00C35275
	for <linux-block@archiver.kernel.org>; Mon,  7 Feb 2022 06:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiBGGgq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Feb 2022 01:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359493AbiBGGAY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Feb 2022 01:00:24 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FCDC03E94E
        for <linux-block@vger.kernel.org>; Sun,  6 Feb 2022 21:59:57 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p24so1102391ejo.1
        for <linux-block@vger.kernel.org>; Sun, 06 Feb 2022 21:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9rTPpwmidEGnk+0sbSsiZSlt9G/HqE6uqYlGM1FbJrE=;
        b=ZPsLtFOYJbXBSXxznzdt6saaoAsr34Sl7BH/YzNYyc4mKr+jF1/vWJs4821VBIp3nd
         wAYRJJhMyvhlRFFisqHrDjp3T/ANdglvZW7vbhim8qaT+0XVsRhXzCNzful3NCALrp54
         PW1YQoTI1urvAHNes0ksAMk17gRSAHs876hKsGuFZuK04GXSCo0Wyy72Qos1yKpfNsRa
         c33fVswSl+9Zgo7TNVcf9DIYAV8qMovu2V8xMiLYKYdXvQM6iOtk8FdCGp/A+BQyObme
         CHMm4XagJ1tLS1aHx+VkjswYOr9+doWYsCysM5Ckp+wImryY23239tWH9wJ+2Ivyiyzj
         F0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9rTPpwmidEGnk+0sbSsiZSlt9G/HqE6uqYlGM1FbJrE=;
        b=RejDEBigJcMIr31hwXnK+uby0MgBu1wo+JnCCD/GULDaEr+dBOeF2rGBk+ahvDaMc5
         KV0j3LsQ0o9i8SiHaPAsLVUSBZzwcxvP74LL/QJ3hmxX8ZzQzbZrJ6c4sYjm84JEXf1b
         D3jz4RTJFRF3h0Qq6y3oXh6R9FEzWH2b+vCP2nXge6jwbJqlfLe06jSyss7UpGLcgXpP
         DeGyWaAikzvex81dI3Z74fJMBmfGm8QUB6TeUpEHzJJRKlz5LX8C+B5+Ctt2YVfTzSPP
         o+75DAQi7lJ991w3yvQvXy400XqzabiGCRe694SjbOu9H76ZYnWe7X+00Ql2hCKw2ueB
         yIzQ==
X-Gm-Message-State: AOAM531fzpvCWF8GoX1TM37e1WsYnbXdXBYyUnQgt61UxYq+AaC//VGf
        CvuFf4kPl55vAmI/pQF3oAhXpukr/qu6WRWZN1VKXw==
X-Google-Smtp-Source: ABdhPJwHixuY4BY25/LApjenuCxsEqMvyZQIitDtOk4Mx5x6JQpUNYhkL601O0c52Dw4YwAFtYtpdEb4+TG5nbiNeRU=
X-Received: by 2002:a17:907:6da6:: with SMTP id sb38mr8757776ejc.58.1644213596468;
 Sun, 06 Feb 2022 21:59:56 -0800 (PST)
MIME-Version: 1.0
References: <a1b05cd5bee83778812c70e115e31b2e49cbad2a.1644139163.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <a1b05cd5bee83778812c70e115e31b2e49cbad2a.1644139163.git.christophe.jaillet@wanadoo.fr>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 7 Feb 2022 06:59:45 +0100
Message-ID: <CAMGffEkGAtxraD_JmSntzXTkWEze55qjb8LCfarBSxUNZY57aw@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: Remove a useless mutex
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Feb 6, 2022 at 10:19 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> According to lib/idr.c,
>    The IDA handles its own locking.  It is safe to call any of the IDA
>    functions without synchronisation in your code.
>
> so the 'ida_lock' mutex can just be removed.
> It is here only to protect some ida_simple_get()/ida_simple_remove() calls.
Hi Christophe,


 ida_simple_get() and ida_simple_remove() are deprecated. Use
 ida_alloc() and ida_free() instead respectively.

 While at it, can you convert the api too?

Thanks!
Jinpu Wang

>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 9a880d559ab8..eaff369eff36 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -23,7 +23,6 @@ MODULE_LICENSE("GPL");
>
>  static int rnbd_client_major;
>  static DEFINE_IDA(index_ida);
> -static DEFINE_MUTEX(ida_lock);
>  static DEFINE_MUTEX(sess_lock);
>  static LIST_HEAD(sess_list);
>
> @@ -55,9 +54,7 @@ static void rnbd_clt_put_dev(struct rnbd_clt_dev *dev)
>         if (!refcount_dec_and_test(&dev->refcount))
>                 return;
>
> -       mutex_lock(&ida_lock);
>         ida_simple_remove(&index_ida, dev->clt_device_id);
> -       mutex_unlock(&ida_lock);
>         kfree(dev->hw_queues);
>         kfree(dev->pathname);
>         rnbd_clt_put_sess(dev->sess);
> @@ -1460,10 +1457,8 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
>                 goto out_alloc;
>         }
>
> -       mutex_lock(&ida_lock);
>         ret = ida_simple_get(&index_ida, 0, 1 << (MINORBITS - RNBD_PART_BITS),
>                              GFP_KERNEL);
> -       mutex_unlock(&ida_lock);
>         if (ret < 0) {
>                 pr_err("Failed to initialize device '%s' from session %s, allocating idr failed, err: %d\n",
>                        pathname, sess->sessname, ret);
> --
> 2.32.0
>
