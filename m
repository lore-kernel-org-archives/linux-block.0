Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8B61A9F93
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947696; cv=none; b=WCTwl+nFeOKz3ADv7o/Pr8H7GLv2dqzYLvMRjFst3gqkTOf7HVfxIO83vEY3h15j/dZtyBK3hmKkgtMbj7atGhkZw+Quz8xXdumAwFJ147I9qkhU9GVRJAaGd4YuaOmbohrdYe0KP6c5c47v3G8rxlLYXPJhtTX/ZohoK8/nHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947696; c=relaxed/simple;
	bh=kVILzI6Rcv/xPVWUmPgm3+NJr9BoYpbmSt+5urioZgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsRb9aJRWlxLi42KOhBwiRsHj1a4J8q9isDYU1gq34jH5erTDrUZ00bHE7tP7zCHq4scLTC/lO9xedyNe/EdMPeSjjukZm4t/S5p+kdfJT7OcJNgvDp0hE1OHjNT7pvP/T8Zh8GumnI1VrEmH1Qf+dAwNkARNxoo/duhH/GWgrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=BfOqrKfq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="BfOqrKfq"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59e607a3824so6407359e87.1
        for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 07:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1771947693; x=1772552493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFevRivktVRUPQgYL6qyTakrG7eyjzt2pjVkSebPhgQ=;
        b=BfOqrKfq9cYqhGoq7G4M6ujlHB/j0OTaJsh/4WB+SRurpfmcD3OrOOGLah++sZCgBF
         I8HP/TGEtejxdmQTQrSpKUSwirN9zkLm91s0Sox7NKAA8eeR/jiqE03XX0FCyNBLGgVb
         i1tWT1HwvPqLGFLUk7IqkWWCYslh9aZztokIT7/qJtAP15Kp2Lmf1F2vwDIkwJ7X0PE+
         Um7CsWCzvXM3AbB/77EQcgU4RCeWXh7a5FusfqRn83Uu4sS+lgeP+XqvOJdNlWwpnShK
         ZtFjF/0Mv/reT83uOKUHjaW10RbWV7JwppVBHhpbM4LdJbHzGSF24rPvjQiLWcnjIlmA
         5s1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771947693; x=1772552493;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFevRivktVRUPQgYL6qyTakrG7eyjzt2pjVkSebPhgQ=;
        b=di8sL4+9BN6ALGGKb6/g3rzgWbSloEo8kz0Z19D0dM554irxUYwhMZNYsG77Cmz/G4
         ysSR+tLTllM4VWHX2XrW78TdXDK5tLqB/UQy2RW64uVNQAY7VzjdQFPvvosbt0ceWBwv
         VEt6pVXrwoZa/z0EURuSiHjI+3BbLfnX2cQp9C1imGkka1zd8huOHeFn0d+7wkB5Qvbn
         iq4QOjCHt7UwLxYC4FjxvbrpqwhBBS5vE7j7SIGxnc+TBviBoNbjXxws4sFDFkNnK/fF
         UP07Jtgxklhl9Pxjc72eJS2Phtzwijzm6mY9SeDqGXaSdBV0A5TApSeHn2CgpaIODWmO
         RyLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtQzbpJ3VhDEXGBQtXBRIEQfOY3uxkC4dgyEo9JhSTXpndQKPOpTUyiTMVaAUTdfty6jlyb13WhoVBdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6cLHZ9lss2fDdAcx7Xk8CjmpglQ0OSwN6wYYQOUIEu60Vd5z
	JRIqXKmYffD85l7kk0GrZqkupnVk5UJCl1RBL8quy35Rr3M8IrcTshQZnvekszdmpo0=
X-Gm-Gg: ATEYQzzlFanhudoU7KkMSI4RNcjiTDAkCSXgwFk4qJB1sydoCy3uxXXi8P6NwrXguMZ
	CHT5KOENE1kpWRK8t/l31xAf05U1K6atPsIgEuNGdIe3cyzV1PowINUJSlh7eYn9+evSNvmcq1O
	16iTbvq4sEDYXx+2iY9WPSXhpGI01FaapRyc+AueHQDSrro5ZNz6MQP0cslvAgqL+9ZYX6wZzqo
	cBKtGN8TJajd7wLAR+tmTUlWKE+KXXCv7sQxLPRjryuCj7CgnR6SK1hWrpEZ1QTGY28DVifCgya
	76FmUQTOtU1BuOoWqJNob5vat4VWC+e8PuwjZ++3ehSdYQXyn9v/Q2vw8Z2dICK1qUvZulm1a4Y
	HVQ+Sq2G7UE9/FGxtD7fhclZBxQG5Ll9VLT0GLZYu2Q4unNuxUksdY+CO/O7otQzfYvOkahvrFk
	0FwNLIaqeIeJDJm5ElGvk6ItYLC2j1LWGwdQVDfKJjyf9S3bwyC4iKO5hgY4k0gCNGDJfOjaDY3
	CWGTAMhmvEX1nCwZkLCi7ke2w==
X-Received: by 2002:ac2:4c45:0:b0:59e:657f:438c with SMTP id 2adb3069b0e04-5a0ed9b8e2bmr4003483e87.40.1771947693063;
        Tue, 24 Feb 2026 07:41:33 -0800 (PST)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb4c5bdsm2281642e87.87.2026.02.24.07.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 07:41:32 -0800 (PST)
Message-ID: <2b3db22a-ea67-4a3e-83e5-75eb0cf95258@linbit.com>
Date: Tue, 24 Feb 2026 16:41:31 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/62] drbd: Balance RCU calls in drbd_adm_dump_devices()
To: Bart Van Assche <bvanassche@acm.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Andreas Gruenbacher <agruen@linbit.com>, linux-block@vger.kernel.org,
 "open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
References: <20260223214950.2153735-1-bvanassche@acm.org>
 <20260223214950.2153735-4-bvanassche@acm.org>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20260223214950.2153735-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 23.02.26 um 22:48 schrieb Bart Van Assche:
> Make drbd_adm_dump_devices() call rcu_read_lock() before
> rcu_read_unlock() is called. This has been detected by the Clang
> thread-safety analyzer. Compile-tested only.
> 
> Cc: Andreas Gruenbacher <agruen@linbit.com>
> Cc: linux-block@vger.kernel.org
> Fixes: a55bbd375d18 ("drbd: Backport the "status" command")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/drbd/drbd_nl.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index e201f0087a0f..728ecc431b38 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -3378,8 +3378,10 @@ int drbd_adm_dump_devices(struct sk_buff *skb, struct netlink_callback *cb)
>  		if (resource_filter) {
>  			retcode = ERR_RES_NOT_KNOWN;
>  			resource = drbd_find_resource(nla_data(resource_filter));
> -			if (!resource)
> +			if (!resource) {
> +				rcu_read_lock();
>  				goto put_result;
> +			}
>  			cb->args[0] = (long)resource;
>  		}
>  	}
> @@ -3628,8 +3630,10 @@ int drbd_adm_dump_peer_devices(struct sk_buff *skb, struct netlink_callback *cb)
>  		if (resource_filter) {
>  			retcode = ERR_RES_NOT_KNOWN;
>  			resource = drbd_find_resource(nla_data(resource_filter));
> -			if (!resource)
> +			if (!resource) {
> +				rcu_read_lock();
>  				goto put_result;
> +			}
>  		}
>  		cb->args[0] = (long)resource;
>  	}
> 

Passes our internal DRBD test suite.

Tested-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

