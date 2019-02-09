Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC33C169C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 00:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFB020869
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 00:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iTNeqsfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfBIAQJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:16:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46924 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBIAQJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 19:16:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so2406884pfe.13
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 16:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oryjic6xj+Y9zq3LufTvFA2Vhnmrl3DRW+gIS1Bq8eo=;
        b=iTNeqsfGHYxq1RfX8FFV1waggm7BptqN3SeYa3PrqDgkqHM7BYEPYrkggzDxD31Fsx
         ujKTa8+IyL7fCkeYoLNfFjlbsnphr6xBl6MMyZtsXEPaaqu2TkN0DOnUtsnNtFHtm7Qw
         j5lBsSmJ0SRvl0e7k2CRYL7/rzQc6DIEZtg3XfwSRx0V1lh+htMWzXTx7LqDPqQ1bbG5
         HJ8DY5YDrC8lgw1FvwlN5myeFCbSu1+ziiB0bcE+NquP/f+/WHYW31FFAQEfNrlw4NiD
         kKdDH+JCENa8YiemEjLRJwTSemaNuK5PHqUPjZUteD8LeZMcaLfFlTlIlj80TdhvoIoP
         pwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oryjic6xj+Y9zq3LufTvFA2Vhnmrl3DRW+gIS1Bq8eo=;
        b=fBghsk1w6VNADlhd6288DIKHVjehQeSCewWG/TydEo2EDzo3LQuBIruwwOcjeeomQ9
         IZiE/+0pwk/xmgrZR4fUD6dpfbA7dY38IsQEfSfrs67kUj1W6+p8LHF0CkIR+AEFhOfZ
         KTro82lg25EydTbbr88vmSb+roGxSs2p51YWD0HcrokfYxvyLJbL4KhBKw+WKWAHx46T
         xnNrruEoVK50OVCEWTuNNFYWtxZT38K9ZBigF/v+vvz1VEwz3SU/t3GWm6dilNN37RZj
         IxtMt/JwcI52eXwTOEYNlnLKxRKcUvEGfFSyshSyJV94ugP2K/SpA/puyr9Vue6JvUR5
         d63w==
X-Gm-Message-State: AHQUAuYT0XXR1h4UGWUS6yqQEXk2dJeYf162Z1cfRF42ErTeXhedke9d
        mLaHmwQOMesctNT4i8nNzAJ5sw==
X-Google-Smtp-Source: AHgI3IaT2CuLCOZQtXv3QNrvT1b25a1r/YlNYpRI55f2Rm7iE/4QJUg6JPKxJN1ep8sHyHJzNMR7Mw==
X-Received: by 2002:a65:4507:: with SMTP id n7mr17995489pgq.34.1549671367930;
        Fri, 08 Feb 2019 16:16:07 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m67sm4337020pfb.25.2019.02.08.16.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:16:07 -0800 (PST)
Subject: Re: [PATCH 14/19] io_uring: add file set registration
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20190208173423.27014-1-axboe@kernel.dk>
 <20190208173423.27014-15-axboe@kernel.dk>
 <CAG48ez2Fp10zQ4Y-x4RJh3Cu=vABu9w8ZrAJThvkh6pr74ZiQw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a003733-a1aa-0f55-324d-4bf0360a5df9@kernel.dk>
Date:   Fri, 8 Feb 2019 17:16:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2Fp10zQ4Y-x4RJh3Cu=vABu9w8ZrAJThvkh6pr74ZiQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/19 1:26 PM, Jann Horn wrote:
> On Fri, Feb 8, 2019 at 6:35 PM Jens Axboe <axboe@kernel.dk> wrote:
>> We normally have to fget/fput for each IO we do on a file. Even with
>> the batching we do, the cost of the atomic inc/dec of the file usage
>> count adds up.
>>
>> This adds IORING_REGISTER_FILES, and IORING_UNREGISTER_FILES opcodes
>> for the io_uring_register(2) system call. The arguments passed in must
>> be an array of __s32 holding file descriptors, and nr_args should hold
>> the number of file descriptors the application wishes to pin for the
>> duration of the io_uring instance (or until IORING_UNREGISTER_FILES is
>> called).
>>
>> When used, the application must set IOSQE_FIXED_FILE in the sqe->flags
>> member. Then, instead of setting sqe->fd to the real fd, it sets sqe->fd
>> to the index in the array passed in to IORING_REGISTER_FILES.
>>
>> Files are automatically unregistered when the io_uring instance is torn
>> down. An application need only unregister if it wishes to register a new
>> set of fds.
> 
> I think the overall concept here is still broken: You're giving the
> user_files to the GC, and I think the GC can drop their refcounts, but
> I don't see you actually getting feedback from the GC anywhere that
> would let the GC break your references? E.g. in io_prep_rw() you grab
> file pointers from ctx->user_files after simply checking
> ctx->nr_user_files, and there is no path from the GC that touches
> those fields. As far as I can tell, the GC is just going to go through
> unix_destruct_scm() and drop references on your files, causing
> use-after-free.
> 
> But the unix GC is complicated, and maybe I'm just missing something...

Only when the skb is released, which is either done when the io_uring
is torn down (and then definitely safe), or if the socket is released,
which is again also at a safe time.

>> +static void __io_sqe_files_unregister(struct io_ring_ctx *ctx)
>> +{
>> +#if defined(CONFIG_UNIX)
>> +       if (ctx->ring_sock) {
>> +               struct sock *sock = ctx->ring_sock->sk;
>> +               struct sk_buff *skb;
>> +
>> +               while ((skb = skb_dequeue(&sock->sk_receive_queue)) != NULL)
>> +                       kfree_skb(skb);
>> +       }
>> +#else
>> +       int i;
>> +
>> +       for (i = 0; i < ctx->nr_user_files; i++)
>> +               fput(ctx->user_files[i]);
>> +#endif
>> +}
>> +
>> +static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
>> +{
>> +       if (!ctx->user_files)
>> +               return -ENXIO;
>> +
>> +       __io_sqe_files_unregister(ctx);
>> +       kfree(ctx->user_files);
>> +       ctx->user_files = NULL;
>> +       return 0;
>> +}
>> +
>> +#if defined(CONFIG_UNIX)
>> +static int __io_sqe_files_scm(struct io_ring_ctx *ctx, int nr, int offset)
>> +{
>> +       struct scm_fp_list *fpl;
>> +       struct sk_buff *skb;
>> +       int i;
>> +
>> +       fpl = kzalloc(sizeof(*fpl), GFP_KERNEL);
>> +       if (!fpl)
>> +               return -ENOMEM;
>> +
>> +       skb = alloc_skb(0, GFP_KERNEL);
>> +       if (!skb) {
>> +               kfree(fpl);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       skb->sk = ctx->ring_sock->sk;
>> +       skb->destructor = unix_destruct_scm;
>> +
>> +       fpl->user = get_uid(ctx->user);
>> +       for (i = 0; i < nr; i++) {
>> +               fpl->fp[i] = get_file(ctx->user_files[i + offset]);
>> +               unix_inflight(fpl->user, fpl->fp[i]);
>> +               fput(fpl->fp[i]);
> 
> This pattern is almost always superfluous. You increment the file's
> refcount, maybe insert the file into a list (essentially), and drop
> the file's refcount back down. You're already holding a stable
> reference, and you're not temporarily lending that to anyone else.

Actually, this is me messing up. The fput() should be done AFTER
adding to the socket. I'll fix that.

-- 
Jens Axboe

