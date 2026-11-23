Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795412342;
	b=lxcIKm15QVxivieF/Gw9ix5ydNNTErd7W7tkPLK9CCiWuRDCs8lfbdrGLb9nB8wEX/t/
	 h7JaNbbtkC7Io5Kx3RHAvvbspWH51fmh8nigiXdJEkPo37Z7YDJXkuinfvNK8VQ19u+i1
	 hHgjx4h4pArNOiAeXIkK12Cw+DjUF0rENBIjvkv1pRjAvDCY4+hFV72IK+SIrTP+aZvrT
	 midRQ2MQKdzdHm5cQvgtHH+eIq3eJSHwaDeSldkNDfXnPIUJJQ35CK6tkTjkgaQFLohZ4
	 UcFLxvxWHfN1ykIkT8KFsxokF/53z8PS3jWLdyImla8fWaQBnXntW+VSBrG0Vh6B0Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1clr5r2wO4r4dTZUcOGCWEDQFMnWEIuiQe2vSyPXs6U=;
	b=pbI8yY3eE2VLhMlp5w3QjrlczmpXueGMfljb2G690j54CQWw2Y5p0ItroJZtaKCK6eVH
	 +QcJkvnm+2hYx9pfETSwcEG9U2Oj+PZoV4gtQO+opMCBc3gDEgjblxH50CwyAq8+HWpi/
	 dIraLX+KRkPl6Tcke/XgbD18ETnRLdHK1PUEC9aFibNVL8nV5uC0ts9YoKKnmSgKUZdSt
	 eq+TKw1KO1ftutfAQbwTC33jR17RZhV+OVe2EABAAzt0cq/BEc6aCbiSBwfy+mEU3oaM9
	 uZKQ4Qnj1SMp3EWSboOhF4CRkLAcbCe2IwYt6Tjn25zK2Igx2fUpg42NFfwgi8M5+Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JfSnrCNI;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E34606A31E
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 05:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33E34606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JfSnrCNI
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f037bc348dso24013985ad.0
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2026 21:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795412341; x=1796017141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1clr5r2wO4r4dTZUcOGCWEDQFMnWEIuiQe2vSyPXs6U=;
        b=JfSnrCNIKPICj0RrhiN+MnxvrazaYg8GflRhbxQTTHfkuFTNW3UWYoQHRpFBVw0FFW
         CusggcdbmunQhXC+CVemjVC1B/WnKrWhr0v02iPfmyfaSLz951gCOlra3Ih5p3FeIF2O
         ibz8+H8V3z1WuViw6wcap6swTO8LDUGYEVWts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795412341; x=1796017141;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1clr5r2wO4r4dTZUcOGCWEDQFMnWEIuiQe2vSyPXs6U=;
        b=pqcmlpGgmmUfEK5i/32jCYGb+SpX7HaK5k0unR5NhwOX6Dvfzc55pVA4KH042eoeY6
         pr9izPHkSwOP8oUuZfIl7EwF+pYOVZ0gWeOs/sQuTOkHV+BsZmzRB3wossTJjvkpR5xF
         Iog/B0mXARElVl2XXcRIIHpURgr4p7kWUkIQbe1W2aMYLRSpq+Q7rABUAmZWedFBbpV3
         j9PD5L0cf4ldmi9yTJdOJ0rsPqBErefTTk+Qibpi/cZ+1jql5J0O0ShBkSk6e+ivTNWE
         GDyYiiU5Qsr1UJAIBfmOSG8hb8UiFz+sC0EpQ4n8taQpXvV3H/QYUk1wQCMIx7wwMWx3
         A6ow==
X-Forwarded-Encrypted: i=1; AL+hErFQWv/TRzKHIgMZmwJa2iCcsDuyK1Bfxj+FuRRXhvE9Zk2+BuCiDvxWfjD113Rj6EJgQjkfQS5Wtgd+fA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8p2TCBKsi1Djzr6D6mJ40QSFNjmqTnff4d4hDxb+ea1hGkyNQy
	qMiGBTjlbXAbiPwSalOocU5n/OJgWdjzqtRiwL80WrYnET/CHks18I3nq7w96SshRQ==
X-Gm-Gg: AZFdTZejPI2kY/WNYQdOd/Cnvcr/CoIW0nu0TU7xBCraXX5gfeqLUv50eNBxEC5FBy+
	Z2WIKAfPLlei4zhLwuSYpRoFredHc0cM3OsylJWOx2ebKpciClBCkwCWVyeZh1Q+dRIyYuAeqh6
	hc7GZP2qxGyQ93T+EKnUlHr0peKEpF87lh0I+z4GNEOkeAb0S52JylLLP9TNNo5pEOFOu6bSSRA
	W3wYYb2KN48UZQr+xbntUM8WhuIuPuVvSy8Y91871V0Quj5BtielGAINuPlH2tueAOX1Ua3B/zX
	vYS/HOqY+0vtfcI/ja8JuAa89bR0xb174IoM2WO4K+aayHkVzOgvTOg+WANzEqxeTd6TKocvsmJ
	F6Ab3qauljYS46vCvsfgygxmqGDcxkfdtRPpX7eLWwzNVOfgZMZyhbEEanamnZ/Te82EMCk61YR
	mTK0jh3jSMl2JBJXQbruby/ChSOj4RHwD4WuEbqXgZ037sxD7PiC9lo9Y5VFaK0H7w9oO9yv5pX
	TXPKTXVWmvVJdJBCPyuqyvJORozMfSCpwwJqaw5BJb9zWd9MKixHeTkqoaRaYBJAw7I64HxlsKe
	+i7VpzqE1xRqJAtMxFyH3mYGagf8bR7GQVg4ezfAWqO8rfoAWx51CDJ39BXPDKhlTtqWOg==
X-Received: by 2002:a17:903:19e7:b0:2ef:e8f2:ba28 with SMTP id d9443c01a7336-2f03f249c83mr98893775ad.36.1795412341632;
        Sun, 22 Nov 2026 21:39:01 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:d8fa:c511:e415:e0d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f14fc8csm45964775ad.74.2026.11.22.21.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 21:39:01 -0800 (PST)
Date: Mon, 23 Nov 2026 14:38:57 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry@kernel.org>, 
	Hongfeng Chen <hongfengchen@xiaomi.com>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] zram: keep the hot statistics per CPU
Message-ID: <awPRKEk_Q0wRhZx1@google.com>
References: <a74aca7a3d27333972782b29786c7b33861a56f1.1795412161.git.senozhatsky@chromium.org>
 <cd96ecab2cfbb9a50a0b5141c09f9fda086780a0.1795412161.git.senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd96ecab2cfbb9a50a0b5141c09f9fda086780a0.1795412161.git.senozhatsky@chromium.org>

On (26/11/23 14:36), Sergey Senozhatsky wrote:
[..]
> +static u64 zram_stat_read(struct zram *zram, enum zram_pcpu_stat item)
> +{
> +	struct zram_pcpu_stats *stats;
> +	s64 sum;
> +	int cpu;
> +
> +	/*
> +	 * Other CPUs keep updating while the values are added up: a page
> +	 * stored on a CPU already summed and freed on one not yet summed
> +	 * can make the sum negative.  Sum them up again then.
> +	 */
> +	for (;;) {
> +		sum = 0;
> +		for_each_possible_cpu(cpu) {
> +			stats = per_cpu_ptr(zram->pcpu_stats, cpu);
> +			sum += local64_read(&stats->stat[item]);
> +		}
> +		if (sum >= 0)
> +			return sum;
> +		cond_resched();
> +	}
> +}

Oh god... and, of course, I forgot to quash the clamping patch...
What a muppet.
