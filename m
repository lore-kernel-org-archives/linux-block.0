Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B117B506;
	Mon, 17 Feb 2025 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739778420; cv=none; b=HIOecboPOvIP6y+F72CLtvZC52V/IfJpsXLyHGiP+PCrqqwe9+rJrdlP9GZJ0FHk12OpZyv0hp99535EWnVkINJHsMqPQs62I6OyL/UHIIf04q6G17azefy47VjcIKjgSWuQ/9KVxXp80rhMm4JNWs/h8EW69f0G2afeUQ2ldO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739778420; c=relaxed/simple;
	bh=TV+DcSv0rBlwGnRMkFu2YWVSX+uwz1Iucpa56Paj/uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fej7WxB7UL5WNg15qrNPGQKOHD7I7Q2CekzCrZQ2zbSMPMNLV7CanhOTvzICy3VK99ptWQbzJT8zqmFemU79jkK5rvk87lFpf+ISBprw3qnjoSSp0w374IJ7/r3LNsnM0ex+xJxL+5PeRztkVrc+QSdkLGbtGw1guzxxLR7hvIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4398738217aso3466655e9.3;
        Sun, 16 Feb 2025 23:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739778417; x=1740383217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fR4NFxuWiqBPtXAx9wkbxWarDCW/Qvh21Mv1E4CO5ZQ=;
        b=HuUUy9gLBVvd+Nwf/vGqyna5xoGOJTv1o2dP2SCorUXySXI5HQyq6lPXppMVHvOycK
         nXj99NwMZii8nQcRYyUN7maZJuHATp+mCEKxRqmIaWwJv4Y0QFVohEkn0+2YqNKGPPen
         r7p3AqvwQWMqyn+dKwgEMlks2ir+9lfqx+QIagaCD3SxiZP1oY0yq3rblTnEEc0Ty/Vu
         HfuPPX5zpS+bQQeU5KOgC93Fjvm9X2cMIpi2NBSSkFgwY5iMH/BK+kOoEkWIs6sVBapi
         jaHJtwXIpWmuwRac4xnEG/2RppxJHxbJU9u3jR48wxvLOPoxAKptuClmKnTFxT7oBa8k
         vsuw==
X-Forwarded-Encrypted: i=1; AJvYcCX6c63XL0Rlei1WZSRgtWqtXBBE2ODu01WwqAAVVjCiMmy159d88EM6qrT99/SG1OvNsjY2QSolldv1mg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2GiXWuIBwLv2TGXOH6F/zyPG1c1fcD5C9Z3oOWZ39Im8Wm2T
	F9/3+YDTy/qsbwdPQBYwADoF7PHYliH4qD2/5hx8Prv5+YKKDq5R
X-Gm-Gg: ASbGncu1SB2N2CSgr4yG6/eLjbxQCEHVhYyJayPRoTujxMcJX5NdNTyrBShUj5erpnv
	GjGrnQ33funTZJ/Vv22SHoVYZa+MR8yRKlSQ4XLHkIfpaFj2nBglDePpodRXapEqFh/KqEHxsH7
	/BULMib3W13IlLiqXrbYqd7+NbsFqonqAr0C6uO2CRHiRXTC6tw0x/wlsWfTW5ff5IWrxqQvYX7
	13Leblx+M8dos2HmCJjw8/mXEA8YaQ0BOsmKX/kHG4CaaAX1YjYvFaZ3VOlvmhCelNfZavtK9FN
	BSH9lTR4ZIBV8oV+Eq9UrrfFpFFjjFeUbzXk8YEAOGAt9vyjFM2iniXkyg==
X-Google-Smtp-Source: AGHT+IFTyXYgme3ewuDw6Ewz/zTtLzn9WnLnVAoLj/JUS8cfpqVznqbExQI7kKDa0eJV3cJ1O50wQg==
X-Received: by 2002:a05:600c:3106:b0:439:6619:9c1c with SMTP id 5b1f17b1804b1-4396e6d9a8bmr80630955e9.18.1739778416737;
        Sun, 16 Feb 2025 23:46:56 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987088ecbsm13388325e9.31.2025.02.16.23.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 23:46:56 -0800 (PST)
Message-ID: <aed9dde7-3271-4b97-9632-8380d37505d9@grimberg.me>
Date: Mon, 17 Feb 2025 09:46:55 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>,
 mgurtovoy <mgurtovoy@nvidia.com>, kbusch <kbusch@kernel.org>,
 sashal <sashal@kernel.org>, "chunguang.xu" <chunguang.xu@shopee.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>
References: <2025021015413817916143@cestc.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2025021015413817916143@cestc.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 10/02/2025 9:41, zhang.guanghui@cestc.cn wrote:
> Hello
>
>
>
>      When using the nvme-tcp driver in a storage cluster, the driver may trigger a null pointer causing the host to crash several times.
>
>
>
> By analyzing the vmcore, we know the direct cause is that  the request->mq_hctx was used after free.
>
>
>
>
>
> CPU1                                                                   CPU2
>
>
>
> nvme_tcp_poll                                                          nvme_tcp_try_send  --failed to send reqrest 13
>
>
>
>      nvme_tcp_try_recv                                                      nvme_tcp_fail_request
>
>
>
>          nvme_tcp_recv_skb                                                      nvme_tcp_end_request
>
>
>
>              nvme_tcp_recv_pdu                                                      nvme_complete_rq
>
>
>
>                  nvme_tcp_handle_comp                                                   nvme_retry_req -- request->mq_hctx have been freed, is NULL.
>
>
>
>                      nvme_tcp_process_nvme_cqe
>
>
>
>                          nvme_complete_rq
>
>
>
>                              nvme_end_req
>
>
>
>                                    blk_mq_end_request
>
>
>
>
>
>
>
> when nvme_tcp_try_send failed to send reqrest 13, it maybe be resulted by selinux or other reasons, this is a problem. then  the nvme_tcp_fail_request would execute。
>
>
>
> but the nvme_tcp_recv_pdu may have received the responding pdu and the nvme_tcp_process_nvme_cqe would have completed the request.  request->mq_hctx was used after free.
>
>
>
> the follow patch is to solve it.

Zhang, your email client needs fixing - it is impossible to follow your 
emails.

>
>
>
> can you give  some suggestions?  thanks!

The problem is the C2HTerm that the host is unable to handle correctly.
And it also appears that nvme_tcp_poll() does not signal correctly to 
blk-mq to stop
calling poll.

One thing to do is to handle C2HTerm PDU correctly, and, here is a 
possible fix to try for the UAF issue:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c637ff04a052..0e390e98aaf9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2673,6 +2673,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx 
*hctx, struct io_comp_batch *iob)
  {
         struct nvme_tcp_queue *queue = hctx->driver_data;
         struct sock *sk = queue->sock->sk;
+       int ret;

         if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
                 return 0;
@@ -2680,9 +2681,9 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx 
*hctx, struct io_comp_batch *iob)
         set_bit(NVME_TCP_Q_POLLING, &queue->flags);
         if (sk_can_busy_loop(sk) && 
skb_queue_empty_lockless(&sk->sk_receive_queue))
                 sk_busy_loop(sk, true);
-       nvme_tcp_try_recv(queue);
+       ret = nvme_tcp_try_recv(queue);
         clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
-       return queue->nr_cqe;
+       return ret < 0 ? ret : queue->nr_cqe;
  }

  static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int 
size)
--

Does this help?
