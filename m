Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682A1C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280872184D
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iJaNBSiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfA2XPA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:15:00 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54472 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfA2XPA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 18:15:00 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so7362329ita.4
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 15:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=48H+k7ekuXgZDmOUMRJuxIKb7hGvulTDfURG2NK4Ks0=;
        b=iJaNBSiNr5fSIrCWkKzIh4/sx/4HpOyuQQxENOiyJkQlAYzhSysNFPC0RlQKS8nUTR
         t5Gf4Hjra4zmpI03rTPfKbORI9J+P7PJm3MMuzsxuGqiCF77SqM4Ilw8W1IcRNV4wUjy
         ERPvZP04GWKkvuzqaWrxIZewiMNrxrboNqF6JPe1l/P52PtK3RqvfASegndrjlpoIrWn
         If6ah7+7/MVlujYZu9ElBFT9m635KTL+ciJbDnlOFRnIz0CYv+Zawm/sktaZjBlyXNBV
         Az53pZgfNrlt0XrCEh6nEzGoW1+7ZgVwMdyju3Nv0b9VEeMioS+KYvDD6wiqWLYHKrnH
         fjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=48H+k7ekuXgZDmOUMRJuxIKb7hGvulTDfURG2NK4Ks0=;
        b=OBbKYxUISwbdiS/1p2LLRKr08ekd45YEi2oA+ACgmHwL4KKYicFjveNF+GZMmCbtSL
         YFiL3E5Jf0HDehp0EQJ6+DP/cdBdrGv9JMBU0pDA7f+5ggQ82MiZv+equZZrNItGyT6Y
         KOkA+gv/Vt3L/vlQIax8vx4x4ONDfauE405hM6ITXr9it+er+a2Y9zcF1WRtjZnoHOKA
         dHBXV/bHPUtU5Dioe6ykJy1afliEBy4jJqFJQUOtnT2jbh87+GL7ttRscma9//ZpQCwH
         tFt4tOTcAhUCeA4wWBhrPUSCCGhe+Dx9gLM4HnlGhPk7EwHKN+HvKPlUeeOu3lqlOb0b
         rxyg==
X-Gm-Message-State: AJcUukfZ3LTTfa7rQtylEm+7QLrUANBr8Lcmf2dFRZrLvE/fSscZYTeG
        An6mPal/ZPA0rhmV+zd+tIe/cEAV74M=
X-Google-Smtp-Source: AHgI3IbIfXo6d5lWObrA8j1lfj4p1BgeMR2razuxWqGYHu1L4wcbrbfAerAHnQ/FxsG9yr+zl5NFsw==
X-Received: by 2002:a05:660c:11c6:: with SMTP id p6mr14030791itm.75.1548803698831;
        Tue, 29 Jan 2019 15:14:58 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l3sm117496itb.43.2019.01.29.15.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 15:14:57 -0800 (PST)
Subject: Re: [PATCH 12/18] io_uring: add support for pre-mapped user IO
 buffers
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190129192702.3605-1-axboe@kernel.dk>
 <20190129192702.3605-13-axboe@kernel.dk>
 <CAG48ez2VkeSEZA+9H4UAcg86uC77gU=UkTG8L1V58TuR9pDEqg@mail.gmail.com>
 <dd366179-c003-752f-743d-2bea4f6b796c@kernel.dk>
 <CAG48ez3x5x+P=8L1p-bHvcUnypeT1TizkXq2+Q0bCP0GdE-bog@mail.gmail.com>
 <87b25ce2-a5bc-3e81-ddba-5c932c71b40f@kernel.dk>
 <CAG48ez1m22z0Pqi0cT=UZdsA14SCM5579T1d40cZdyD6KqBw_g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <379a631f-e55b-cc31-f84a-ace73fd66ea1@kernel.dk>
Date:   Tue, 29 Jan 2019 16:14:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1m22z0Pqi0cT=UZdsA14SCM5579T1d40cZdyD6KqBw_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 4:08 PM, Jann Horn wrote:
> On Wed, Jan 30, 2019 at 12:06 AM Jens Axboe <axboe@kernel.dk> wrote:
>> On 1/29/19 4:03 PM, Jann Horn wrote:
>>> On Tue, Jan 29, 2019 at 11:56 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>> On 1/29/19 3:44 PM, Jann Horn wrote:
>>>>> On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>> If we have fixed user buffers, we can map them into the kernel when we
>>>>>> setup the io_context. That avoids the need to do get_user_pages() for
>>>>>> each and every IO.
>>>>>>
>>>>>> To utilize this feature, the application must call io_uring_register()
>>>>>> after having setup an io_uring context, passing in
>>>>>> IORING_REGISTER_BUFFERS as the opcode. The argument must be a pointer
>>>>>> to an iovec array, and the nr_args should contain how many iovecs the
>>>>>> application wishes to map.
>>>>>>
>>>>>> If successful, these buffers are now mapped into the kernel, eligible
>>>>>> for IO. To use these fixed buffers, the application must use the
>>>>>> IORING_OP_READ_FIXED and IORING_OP_WRITE_FIXED opcodes, and then
>>>>>> set sqe->index to the desired buffer index. sqe->addr..sqe->addr+seq->len
>>>>>> must point to somewhere inside the indexed buffer.
>>>>>>
>>>>>> The application may register buffers throughout the lifetime of the
>>>>>> io_uring context. It can call io_uring_register() with
>>>>>> IORING_UNREGISTER_BUFFERS as the opcode to unregister the current set of
>>>>>> buffers, and then register a new set. The application need not
>>>>>> unregister buffers explicitly before shutting down the io_uring context.
>>> [...]
>>>>>> +       imu = &ctx->user_bufs[index];
>>>>>> +       buf_addr = READ_ONCE(sqe->addr);
>>>>>> +       if (buf_addr < imu->ubuf || buf_addr + len > imu->ubuf + imu->len)
>>>>>
>>>>> This can wrap around if `buf_addr` or `len` is very big, right? Then
>>>>> you e.g. get past the first check because `buf_addr` is sufficiently
>>>>> big, and get past the second check because `buf_addr + len` wraps
>>>>> around and becomes small.
>>>>
>>>> Good point. I wonder if we have a verification helper for something like
>>>> this?
>>>
>>> check_add_overflow() exists, I guess that might help a bit. I don't
>>> think I've seen a more specific helper for this situation.
>>
>> Hmm, not super appropriate. How about something ala:
>>
>> if (buf_addr + len < buf_addr)
>>     ... overflow ...
>>
>> ?
> 
> Sure, sounds good.

Just folded in this incremental, which should fix all the issues outlined
in your email.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7364feebafed..d42541357969 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -751,7 +751,7 @@ static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
 {
 	size_t len = READ_ONCE(sqe->len);
 	struct io_mapped_ubuf *imu;
-	int buf_index, index;
+	unsigned index, buf_index;
 	size_t offset;
 	u64 buf_addr;
 
@@ -763,9 +763,12 @@ static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
 	if (unlikely(buf_index >= ctx->nr_user_bufs))
 		return -EFAULT;
 
-	index = array_index_nospec(buf_index, ctx->sq_entries);
+	index = array_index_nospec(buf_index, ctx->nr_user_bufs);
 	imu = &ctx->user_bufs[index];
 	buf_addr = READ_ONCE(sqe->addr);
+
+	if (buf_addr + len < buf_addr)
+		return -EFAULT;
 	if (buf_addr < imu->ubuf || buf_addr + len > imu->ubuf + imu->len)
 		return -EFAULT;
 
@@ -1602,6 +1605,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 
 static int io_sq_thread(void *data)
 {
+	struct io_uring_sqe lsqe[IO_IOPOLL_BATCH];
 	struct sqe_submit sqes[IO_IOPOLL_BATCH];
 	struct io_ring_ctx *ctx = data;
 	struct mm_struct *cur_mm = NULL;
@@ -1701,6 +1705,14 @@ static int io_sq_thread(void *data)
 		i = 0;
 		all_fixed = true;
 		do {
+			/*
+			 * Ensure sqe is stable between checking if we need
+			 * user access, and actually importing the iovec
+			 * further down the stack.
+			 */
+			memcpy(&lsqe[i], sqes[i].sqe, sizeof(lsqe[i]));
+			sqes[i].sqe = &lsqe[i];
+
 			if (all_fixed && io_sqe_needs_user(sqes[i].sqe))
 				all_fixed = false;
 
@@ -2081,7 +2093,7 @@ static int io_copy_iov(struct io_ring_ctx *ctx, struct iovec *dst,
 	struct iovec __user *src;
 
 #ifdef CONFIG_COMPAT
-	if (in_compat_syscall()) {
+	if (ctx->compat) {
 		struct compat_iovec __user *ciovs;
 		struct compat_iovec ciov;
 
@@ -2103,7 +2115,6 @@ static int io_copy_iov(struct io_ring_ctx *ctx, struct iovec *dst,
 static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 				  unsigned nr_args)
 {
-	struct vm_area_struct **vmas = NULL;
 	struct page **pages = NULL;
 	int i, j, got_pages = 0;
 	int ret = -EINVAL;
@@ -2138,7 +2149,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 		 * submitted if they are wrong.
 		 */
 		ret = -EFAULT;
-		if (!iov.iov_base)
+		if (!iov.iov_base || !iov.iov_len)
 			goto err;
 
 		/* arbitrary limit, but we need something */
@@ -2155,14 +2166,10 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 			goto err;
 
 		if (!pages || nr_pages > got_pages) {
-			kfree(vmas);
 			kfree(pages);
 			pages = kmalloc_array(nr_pages, sizeof(struct page *),
 						GFP_KERNEL);
-			vmas = kmalloc_array(nr_pages,
-					sizeof(struct vma_area_struct *),
-					GFP_KERNEL);
-			if (!pages || !vmas) {
+			if (!pages) {
 				io_unaccount_mem(ctx, nr_pages);
 				goto err;
 			}
@@ -2176,32 +2183,18 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 			goto err;
 		}
 
-		down_write(&current->mm->mmap_sem);
-		pret = get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
-						pages, vmas);
-		if (pret == nr_pages) {
-			/* don't support file backed memory */
-			for (j = 0; j < nr_pages; j++) {
-				struct vm_area_struct *vma = vmas[j];
+		down_read(&current->mm->mmap_sem);
+		pret = get_user_pages_longterm(ubuf, nr_pages,
+						FOLL_WRITE | FOLL_ANON, pages,
+						NULL);
+		up_read(&current->mm->mmap_sem);
 
-				if (vma->vm_file) {
-					ret = -EOPNOTSUPP;
-					break;
-				}
-			}
-		} else {
-			ret = pret < 0 ? pret : -EFAULT;
-		}
-		up_write(&current->mm->mmap_sem);
-		if (ret) {
-			/*
-			 * if we did partial map, or found file backed vmas,
-			 * release any pages we did get
-			 */
+		if (pret != nr_pages) {
 			if (pret > 0) {
 				for (j = 0; j < pret; j++)
 					put_page(pages[j]);
 			}
+			ret = pret < 0 ? pret : -EFAULT;
 			io_unaccount_mem(ctx, nr_pages);
 			goto err;
 		}
@@ -2224,12 +2217,10 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 		imu->nr_bvecs = nr_pages;
 	}
 	kfree(pages);
-	kfree(vmas);
 	ctx->nr_user_bufs = nr_args;
 	return 0;
 err:
 	kfree(pages);
-	kfree(vmas);
 	io_sqe_buffer_unregister(ctx);
 	return ret;
 }

-- 
Jens Axboe

