Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574F4C636D3
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 14:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjAaOuv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 09:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjAaOuu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 09:50:50 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4519693D3
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 06:50:48 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id cr11so8680403pfb.1
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 06:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2CZ5T7PWc8s07Sga56jhOM0P1E/aI3cbnrUQlKRrD4=;
        b=XK4d4bppQ9Jr+pY8pO7MQjx+ieJekLfIAKYeLPg9xnRxFIAYUcT1ucqTz0MGGOVM4/
         TwRS7mxNhs7WZW3/Hb//9uWyyJaJ3TTFI+rGZgDcAF1f6wze+ySx62ErnuOmMjn8zDYR
         88/n5yefymo2GwjSvvBm7KXWtsiEMi9jB8V/zuzci5WPtg5beuJJesVrTbGHwd7/W8py
         vX4q0GcK4Bmmso5+krWj/fdto68S/WV2ClxnZe83i3dLlFYl5k5g7qMeLyoe6dZPVfqS
         urKKs3Pvwyc6wng25v4AiHc3/2ncsZxaUali4sXk5s7ZJbsKWiLJYPxa61q9rhgejsSE
         2JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2CZ5T7PWc8s07Sga56jhOM0P1E/aI3cbnrUQlKRrD4=;
        b=GR96IrnjJpAIb5fBEh67oO7Xwcxg7XkQUOQoGqBJjuJhm9EKim6qF/bkKw9uZatrXK
         tL8LjL44j39dQ5yfhOYSc3RSHDkrPmmMo4eNBgd06j8zZmCYv2xwzx2w2yGAuJOW/Yd8
         ACLdhxwYu4h2oUFnBNXwZLyST1A+bqUvBG3iwx/XM3htPAhcguuNZRKkWjkKFkkFUdbx
         /ew/0y9fguvZ3WZ02nHiMh0Baq2OsRX1/neg+y5vlxwTE4HYFefuQI1xd8w8Rd2/egXm
         UDRjRp203OR5cnOp8h2El5MDxzDvw6CfoMfJHr7jRlfy/g0noj+TQ3KzsIWtATE3eGwy
         AxXA==
X-Gm-Message-State: AO0yUKWYOOSHt6lXV1yHA9QQcDRsX8t0MxgOFOl6nF+7TyRZHN9MMPkv
        uZs9hro+I6P44LmubRJasyaebQ==
X-Google-Smtp-Source: AK7set/pemF8LZnzGocLR8IKs4gMVDirJQwg6oXS0qAG7FVsfFcUUoIUqritPfvdcSEkpIUwVUYQnA==
X-Received: by 2002:aa7:8505:0:b0:592:5ec2:a132 with SMTP id v5-20020aa78505000000b005925ec2a132mr5954334pfn.3.1675176647632;
        Tue, 31 Jan 2023 06:50:47 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a28-20020a62d41c000000b00593e4e6516csm2260935pfh.124.2023.01.31.06.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 06:50:47 -0800 (PST)
Message-ID: <f2fb6cc5-ff95-ca51-b377-5e4bd239d5e8@kernel.dk>
Date:   Tue, 31 Jan 2023 07:50:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <040ed7a7-3f4d-dab7-5a49-1cd9933c5445@redhat.com>
 <e68c5cab-c3a6-1872-98fa-9f909f23be79@nvidia.com>
 <3351099.1675077249@warthog.procyon.org.uk>
 <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk>
 <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk>
 <e8480b18-08af-d101-a721-50d213893492@kernel.dk>
 <3520518.1675116740@warthog.procyon.org.uk>
 <f392399b-a4c4-2251-e12b-e89fff351c4d@kernel.dk>
 <3791872.1675172490@warthog.procyon.org.uk>
 <88d50843-9aa6-7930-433d-9b488857dc14@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <88d50843-9aa6-7930-433d-9b488857dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/31/23 6:48?AM, David Hildenbrand wrote:
> On 31.01.23 14:41, David Howells wrote:
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>>>> percpu counters maybe - add them up at the point of viewing?
>>>> They are percpu, see my last email. But for every 108 changes (on
>>>> my system), they will do two atomic_long_adds(). So not very
>>>> useful for anything but low frequency modifications.
>>>>
>>>
>>> Can we just treat the whole acquired/released accounting as a debug mechanism
>>> to detect missing releases and do it only for debug kernels?
>>>
>>>
>>> The pcpu counter is an s8, so we have to flush on a regular basis and cannot
>>> really defer it any longer ... but I'm curious if it would be of any help to
>>> only have a single PINNED counter that goes into both directions (inc/dec on
>>> pin/release), to reduce the flushing.
>>>
>>> Of course, once we pin/release more than ~108 pages in one go or we switch
>>> CPUs frequently it won't be that much of a help ...
>>
>> What are the stats actually used for?  Is it just debugging, or do we actually
>> have users for them (control groups spring to mind)?
> 
> As it's really just "how many pinning events" vs. "how many unpinning
> events", I assume it's only for debugging.
> 
> For example, if you pin the same page twice it would not get accounted
> as "a single page is pinned".

How about something like the below then? I can send it out as a real
patch, will run a sanity check on it first but would be surprised if
this doesn't fix it.


diff --git a/mm/gup.c b/mm/gup.c
index f45a3a5be53a..41abb16286ec 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -168,7 +168,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 		 */
 		smp_mb__after_atomic();
 
+#ifdef CONFIG_DEBUG_VM
 		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
+#endif
 
 		return folio;
 	}
@@ -180,7 +182,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 {
 	if (flags & FOLL_PIN) {
+#ifdef CONFIG_DEBUG_VM
 		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
+#endif
 		if (folio_test_large(folio))
 			atomic_sub(refs, folio_pincount_ptr(folio));
 		else
@@ -236,8 +240,9 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
 		} else {
 			folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
 		}
-
+#ifdef CONFIG_DEBUG_VM
 		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
+#endif
 	}
 
 	return 0;

-- 
Jens Axboe

