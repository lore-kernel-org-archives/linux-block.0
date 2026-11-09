Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235521;
	b=BFUaBK/DjIAoqdweKzbHDXC5YEB1RkLXlwIjdXYOemIVY/IPtWB1rPLbr/61gMhBiHDc
	 yv1ljd6bbFM/zeWXtDSAgA6eKxk/ygZ6+qGlvKRANC5uT2g8RUku+osBSWdverbZBTtZL
	 Y2q6nN/MlPzPmNPNZ8lX9JLCsjo2J6qnJvr//nncOXtVroUCNYTzQPehbrvh77/yVyMLz
	 OhSelp/ootRjz02uHHRwSleMO4CPJfqY558KPALa0toP/Jmthc8I9Oe64ShNlIgNQBmLP
	 VqxXechIUYDAGdi/YBY4mjMIZO/p+ycGTFnRMh+VKa4afI0G5cbNH08ZJfwKijsT/0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=QjfeGxjBgHeFZbXRRkDc44FRNrdtYAfDOz72ekRK868=;
	b=3XGDiqYYcromeUL4bw5cIQyS/Mt+3K2g3Gvmiz3FMAX5G3s47cT0HYqf3axjbL8IKWmH
	 7ZkkQ/B0eyaRxKZhwwGsQmBuNWVlq9Gn2XqKaTsmR3ZImc9fIB9lyFOpNbLMWi914G5Eb
	 B6q34q4zqYKwZyBcbRgLNf5XxELGqaK2oCS2DtkqSnnB7vPa1/3UdlBRFj9gOZ30zBsdi
	 UgXcJnQp/5FRFpqBEEuD12TQHdg2/0eSwYsM1WS7VVYJojuOc2NZ4Gpm/quLXjyiMQ2dn
	 ZDId8dg88mBuT0K8LtOHMEtUuxD7awY9dWR4WxP14ogCMGN2rta3KHmmg6IWdLzB/Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="KFK/aQtF";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB446606A323
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 14:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB446606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KFK/aQtF
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a215e64962so11132715e9.1
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 06:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794235519; x=1794840319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QjfeGxjBgHeFZbXRRkDc44FRNrdtYAfDOz72ekRK868=;
        b=KFK/aQtFLegNJK98LFKD6Oei6GWS+XtyERPvlnh3sq5FpPVcwCiSzWXGwfa8mHLIqj
         dCjo6QncuJKoLD2WgqM9z8eUjaxPgrZzy4D0hA2wFNMBVoUx/CpT/Bg+B/GfOl6piu4B
         llRf1PC7DeOLOeSVJhDLYlWfqRmJ39ikqx+j6Ys+ArOHBRvh1TdHC6zfAG7ZBb6e9dr6
         36C+cMpJXL3NAnyLSRcFWm8Lae2mY89MZAsLEOI7g1ieKNuEHjow1+aPmGsBfmxeMLBU
         HUOy3beoZ8qRnsMffISED9gHNm93zZuayygzoIOMGFehfRmJ0DCspRBQpWVa1p6DjZ0j
         Irig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794235519; x=1794840319;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QjfeGxjBgHeFZbXRRkDc44FRNrdtYAfDOz72ekRK868=;
        b=0pNP2Wuwk7M8Pl4qc6G5y6JnRz/SLUFnkKaYHVNwmK4dIsxNYre9LSabe0x1zXl0gG
         EfGHNXd6jJYmnIgeCdb11lA2gjH+Y0aYD0wZG5DTdvN8HyKih4W0XSvW9D+9IqLa1701
         d3BxpJ6I1k3YFEHQckSaqqI0SBz1DB9CbFkF7KXb2cM4jLSUzCyU5O5nQFlpjMiBOL/A
         itzB68Jy+g2KqCZ72EH7FIMMQKdqFKAP5/GJC28v/aRQ+I707sQYHpGo6ODFkr1Qc7UP
         hh7UYgB/mSAc5FOf0HN5ecjGSasfLaeXggUCaLPN0OS1D/uv2MhN/TfSl/wnhxn2GyB+
         BvWg==
X-Gm-Message-State: APuU4Z9N1pGkbJUdTSQ1l2gq5+UxJsJE1bN40LvB6zR7zUAcy9kRuVTI
	BRyw141QN8t1oO3jzOXj9xiorSFFkNKASbf4YDYM5YZ+tK4BGy8OCJ29WWlYa43OxwUOr01M6nh
	QvfTPlaw=
X-Gm-Gg: AYBFou2yHOKGqDoVQ7nu+Vh2aXMXIQrN63B+DXVUZPiHbOWQBBPMWzP/zhb1mi3TAuR
	cXFiaGsDwzltcmNfP5QU3d+Qn5OOXBqJGDhC/a5Jnb27AvLjrtd2fvetujZoJseBnCxhuufUpoe
	7AL9JOLeKxXATsokrVlESIIC2Jf977chieEh/oEx4ZySzrcw05IIzQXqVWcJqSEyeLvPphzwZrP
	1LwfkB3ZOw6KbBciZHTf6D1TxpbwCAVie69rx8FwajF3L2jR36KHg6FUrpnYmGzYRh+UbXKB0uc
	qJk/WmwmQAiSZsRqtzdWAl5+5/1pfLJNl69rm/sSjVbt5KLE3d9ge/5exx2ZQS1LxWIBUWAKCha
	NCoOqTxcX4yF2Tt4KuQpro+VNYP9foeeI8OLvdjjXOEYSgd0uR1o2Gwze5WKhp770lCzfiGSV9I
	jeT2+VB93xC2w//9mcaEf6awYMHx9l3fENK5BngtIKv8lYh5TbaIvGyumfZGIzunIxTO8BxkMFZ
	scuQgKCLJenc1+OkCnLoBbJ/kFuvqezWULMxdsU7HIbaywJsrjBTamWbNaX0rqXRLKg97Wu054Y
	xZ2HAsApaprtPcGAKqc4OMIWbkZbNwI1SUfxxGypXkIyzK4VuTs4KFfMVHiR
X-Received: by 2002:a05:600c:a00d:b0:4a5:5fb9:5d35 with SMTP id 5b1f17b1804b1-4b963c8e853mr65569055e9.21.1794235519093;
        Mon, 09 Nov 2026 06:45:19 -0800 (PST)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4967a70a35dsm7723097f8f.9.2026.11.09.06.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 06:45:18 -0800 (PST)
Message-ID: <94510397-fef7-4856-a8cf-c9f5d9dd0ed8@suse.com>
Date: Mon, 9 Nov 2026 15:45:17 +0100
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
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 kernel-security-sentinel@lists.suse.com
From: Hannes Reinecke <hare@suse.com>
Subject: Automated commit blacklisting
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey all,

apparently there is an automated blacklisting bot running (cf 
bug#1285635). However, there _also_ is another bug referencing
the same commit (bug#1285636), for which the bot did not do
a blacklist.

Which is a tad annoying.

Can we somehow fix this up?
IE can we modify the bot to not do automated action if there
is another bugzilla pending?
Or can we modify the bot to cross-link the bugzilla entries
such that one can see what's happening?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                                 +49 173 5876786
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: J.Jaser, A.McDonald, W.Knoblich

