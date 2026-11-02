Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617740;
	b=oCOL8eRreJkCPgzqn1f+gCvz/0FMCQjNaIhoAnyA3u9SASEeJADQX0dd8c8SUOYyFNKB
	 zNTZE4y4e4pJ0/KP1ocEcGgDVcouaWv+L8cQvg8E1Kly7je6CjhnA3x7iNp2uGMKNZgt/
	 E2gHuc5hLbwNxGFvarfu2EFKzpEGfqpyOiGp7GgzwiqrAFnUIoeAoUQTc+jMswXn/T4Zn
	 OVbfW7CKUhvFdjMAi2CzkG5SEc0VIzHE2JrYOy9r3d4Cl+Bf0ZfaWh0y3z0MuyAtCTOYQ
	 Dd8f7me0XXa0VYjNRQD8qAWDNrsrGIOiBoPKxBYeHudCSItKuPjIhextCwVuqolwDuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=kogwx6wOFEx8wkc1OUmn08NcuZSkF+8EZ7OoR4vifO8=;
	b=TW52EY8y4yqqrlj3ocdD3kNHWEROccnJAIYZUh29sHztM39yJEXj/gGPUJ1eAQVjYsOo
	 GaoH4scFD7c8wPzZ5miS04QkKF+j1dpfeEJzUJvHspgM72In/Iz7hQhVEuOe+wUffVENk
	 pVi5IlgAXWz/ri0+GGeq6vI58WugrNdIJ0qZq9RqZpk4jNuQlCvIaGFcJuO+X6U8KIE1D
	 Un9Y2CbGxVnZzIsb1NHKxfGJ9hsDAVqWN04H13Se4M4nmq2bxGQN5VTsbpHIf0+P4TV/M
	 8u9JTvfWDqT+8VW9lIu8q7vro1eu/DpFCi+QMWQxfrRf/o8O6fHvxcffdaOm8mQkWQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qt+nxT25;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFB8606A324
	for <linux-block@vger.kernel.org>; Mon,  2 Nov 2026 11:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DFB8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qt+nxT25
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c46822eefb6so385154766b.2
        for <linux-block@vger.kernel.org>; Mon, 02 Nov 2026 03:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793617738; x=1794222538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kogwx6wOFEx8wkc1OUmn08NcuZSkF+8EZ7OoR4vifO8=;
        b=Qt+nxT25+VUAwTzK2Y6d+fGiF0wLVF4G5iT0KoZbkMTm8wWqK/cXR7WGG4duUq7GLQ
         mOuEIfwFM5tjyVyxaMYUH2bRafUMo1DrjeOnIgV/SgJIuLJONqvoYS7mABTuyXKiFS47
         qv+rKih8XH2HHt5tTdMlVpLQ2PwtQqCf0+iw/WtqpQ5YMtnHCDbVlKTrw2GwybvJ/wfg
         tRauBMFLsYPpeyUeJno5oTZkYlfghF8oQlGejTMTWDycQTxPLLmqCC1UXlPbPezIV0HU
         1r9Q+7NkMm581zL47MbiZ5Y9KUBM5clPeREm3nf9vfUP+BPAO6ImMAdK+7tcmXDvvyKl
         y+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793617738; x=1794222538;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kogwx6wOFEx8wkc1OUmn08NcuZSkF+8EZ7OoR4vifO8=;
        b=lSyKOCFPq8sIjaNCIDrsUT5oNpHaHBqZXUVNUap0Do1lKrn7F5THwLTAb/Fj63Ci+C
         VizoFo4a15FMce2cieRZbR7C0diICW4LjINaIqBg7EQiEUiBMAd0jY38mK9CFb2cMiTY
         tsbDGiWl4fbtwLz53OknYYBe2awfxcVafONZVGMrexLsu/dlJsvfSAx3f/C2BxKza5e6
         IJTWkGKfESwnXB+zjNsquZzjHYZu+qGPyGPTsH9NFBaVUCVuU2haBjFxHGomqoTy6kwV
         uloPSbPpkyiWmYIBrsRayCFnQv4u1GyPxQOjByA4FdMrIwMJ3T6SIsidP5vC8yLW+6tj
         kLcA==
X-Forwarded-Encrypted: i=1; AKwUvByq1NsUdZT/4AtGc2WR95y/5sMEa3wKCQ8vPA9bRpdIThpDv7SuR9Ir+Oy3YkD+FQ59D3KJMa2UVxGaFQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+d61AgoVczfDmNvL+5ikWG7infjwFuN//rjgr/KbWHk2vHKWZj
	onu+zMufOmD4BUet1U+xi79vMylKS9STRzFTPy27N/NuXPib2Pcji1fU
X-Gm-Gg: AYBFou2MUiEzoFpcJu4/bWFDf1hQs4oce7wr2QS63CNPFJDEZMDO3hq6MkjE6C6xStx
	8WfJcyJWk4p4BB5gCpadH7qpoRdlS2XYfKK6FnbZGNwOP1AFRDd6J08LCrZH0ZK0LMusGjiXsqK
	Gbni3k6ShD07eIXSfXkyy/NoRRcI3ZWzSzfjs9qwR6Rx+7UlbpiigGV3eg1uv+LD6vOMM76K1uE
	RDrXdqvPvPvUrs+bPKAdOkI94huHVwJyYDlL1i2Hh52ohOKyRJq6MypLiRfU76aqh4RNerqtOIy
	LaPAv4fTVgPHfiOMfJYd4F1Xkyvaqt/gArYSPeeVhWk5Uw97XiUg1+pZyT+Q/cB0vrMoA48vkML
	ssALW3qHlnpPba5kf6tiW5AIzbS4HIv9s/i0pnpnlymK6qPoFYC14FE3YnkE3umM3SCn88HgyUc
	kHtjgVt0ZOYpOXKjNJd0BfNBGKLOcBwljNbnWmWkySZjGv8CZNIGQ9gQdYailbVE3xqLLPB2kqq
	7mKkA2DsyCTqRrGRS/ZlXnH6AouBu4vrITgA/mnRLYhz5z9n5sD94o+ToEcfNmuwfilyGYdthIx
	qMqA+aFAxQ88r3jcBYPYBgMn0mZk5wOCncfJULFmILVpnzAo0AksQuxNQ1dkr3SPMftkwi4QjU3
	l9X8YT7vFAXInmq2rlq068jYqsrVTk+jXQrj/MZI+vRAgfu1IO/rlvIdbXXvP3WLf+iCwqJH413
	8MuY8XPCyvDKBFP22/Ntv4JXiV30RsnT+GTwdM4FHGvABxuYMigtA1fM17xIlhlCE=
X-Received: by 2002:a17:907:7fa5:b0:c40:eb1a:4c8b with SMTP id a640c23a62f3a-c4ca7a6d245mr730198166b.29.1793617738242;
        Mon, 02 Nov 2026 03:08:58 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe93db0sm364494766b.66.2026.11.02.03.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 03:08:57 -0800 (PST)
Message-ID: <a8fb3606-017b-464e-a09f-1f1ddf3bc45e@gmail.com>
Date: Mon, 2 Nov 2026 12:08:57 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-mq: fix out-of-bounds read in blk_mq_free_rqs
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot@lists.linux.dev, syzbot+e90526cab23b9efcd03c@syzkaller.appspotmail.com
References: <20261014170538.1089448-1-krystianmkaniewski@gmail.com>
Content-Language: en-US
In-Reply-To: <20261014170538.1089448-1-krystianmkaniewski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/26 19:05, Krystian Kaniewski wrote:
> A KASAN slab-out-of-bounds read can occur in blk_mq_free_rqs() when there
> is a mismatch between the number of hardware queues allocated for the IO
> scheduler (et->nr_hw_queues) and the number of hardware queues in the block
> tag set (set->nr_hw_queues).
> 
> This mismatch can happen if blk_mq_update_nr_hw_queues() fails halfway
> through (e.g., due to memory pressure during
> blk_mq_prealloc_tag_set_tags()). In this error path, the elevator is
> restored with a larger number of hardware queues than the block tag set
> actually has.
> 
> When the elevator is later freed, blk_mq_free_sched_tags() iterates up to
> the new et->nr_hw_queues and calls blk_mq_free_rqs(). In blk_mq_free_rqs(),
> it attempts to access set->tags[hctx_idx] to get the driver tags. Because
> set->nr_hw_queues was not updated due to the earlier failure, set->tags
> still has the old (smaller) size, leading to an out-of-bounds read.
> 
> BUG: KASAN: slab-out-of-bounds in blk_mq_free_rqs+0xde/0x680
> Read of size 8 at addr ffff88818d67fc28 by task syz-executor117/5839
> Call Trace:
>  blk_mq_free_rqs+0xde/0x680
>  blk_mq_free_map_and_rqs+0x40/0xf0
>  blk_mq_free_sched_tags
>  blk_mq_free_sched_res+0xeb/0x280
>  elevator_change_done+0x1d2/0x5c0
>  elevator_change+0x34f/0x480
>  elv_iosched_store+0x504/0x630
>  queue_attr_store+0x207/0x2b0
> 
> To fix this, explicitly check if hctx_idx < set->nr_hw_queues before
> accessing set->tags[hctx_idx]. If hctx_idx >= set->nr_hw_queues, the
> hardware queue doesn't exist in the tag set, meaning there are no driver
> tags to clear mappings from. In this case, safely set drv_tags to NULL. The
> subsequent call to blk_mq_clear_rq_mapping() already handles a NULL
> drv_tags pointer and will safely return.
> 
> Fixes: 04225d13aef1 ("block: fix potential deadlock while running nr_hw_queue update")
> Assisted-by: Gemini:gemini-3.5-flash Gemini:gemini-3.1-pro-preview syzbot
> Reported-by: syzbot+e90526cab23b9efcd03c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e90526cab23b9efcd03c
> Link: https://syzkaller.appspot.com/ai_job?id=827b5760-86a0-4f44-9c69-430b572eac12
> Reviewed-by: Nilay Shorff <nilay@linux.ibm.com>
> Cc: stable@vger.kernel.org # 6.17+
> Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
> ---
> Changes since v1:
> - Drop the additional blk_mq_alloc_rqs() claim, as that path is bounded by
>   set->nr_hw_queues.
> - Add Nilay's Reviewed-by tag.
> - Rebase onto current mainline and refresh the recipient list.
> 
> v1: https://lore.kernel.org/all/c92b0c7e-17fb-44c8-99d9-59d45004d05a@mail.kernel.org/
> 
>  block/blk-mq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 025a799f35b92..259a5705efb79 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3484,8 +3484,10 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>  
>  	if (blk_mq_is_shared_tags(set->flags))
>  		drv_tags = set->shared_tags;
> -	else
> +	else if (hctx_idx < set->nr_hw_queues)
>  		drv_tags = set->tags[hctx_idx];
> +	else
> +		drv_tags = NULL;
>  
>  	if (tags->static_rqs && set->ops->exit_request) {
>  		int i;
> 
> base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
Hi Jens,

A gentle ping on this fix. The patch has Nilay's Reviewed-by, and
syzbot CI tested v2 without finding any issues.

Please let me know if any changes are needed.

Thanks,
-- 
Krystian Kaniewski
