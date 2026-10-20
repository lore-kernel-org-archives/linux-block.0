Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500552;
	b=vi2kgBmlE8nGj0RMP0YZH3Mb6hxOSdavobJW7JywXcfo2ZCHGQAA4wq9qGGVSJ/unIJg
	 Zz0UJE6Xos4ZoGkXiUKoDeG16SQ/iqAR+aKnhyywEEtnAar5rcIofJkKjRtF/b7beTEc1
	 cn+mNP/fjT09ZRNC1IFJoxzxw8PCRxRDXkNi+si3mPGB/etE8YK3XVvdMSjiXI4h30Z7r
	 e7nJqTF4J2x2UzZ7mZYJApFFHI5zSDw+WqZ4rp/9hYz6Py41NqnJnMdy6oqxWOzJ5PcVv
	 sptxSUN+Zh6ZtHrPH1giUqHT/7Ooa48Plx7gRHGUdV7iCO9IaHpZeqAicu1gsFvlaTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500552;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=FAeVOIir4HMk1KRsfGRYBGjRZCtdGNjoG1cMCUcwWcQ=;
	b=qU/FxzLlFrXjAtS/s4xxKdQ0u4baNKoMoB6DrV3VHmd63YU8I3ExiO05WT8MEb+Xxkek
	 vT+wvdPMvhR7A+fwDoCzbL8oikHIaP9su8npZed/9dRlbWj7PG4e8cAF3l2dCbdlYaQW8
	 2Ht55pOtBptF0/tBuRFtR1hfXvuBPtrJt468iwahnTgdqKNQwxYwPVAuRwMbRkqBMr+6n
	 hi9gBzotBeB6SAxctDbY0GdPznhVx5uv0RSfS3hapmoSL2sJV0yQO7yQfaD1s6JUcHum6
	 oMqAQxG5lHt93Pe7O9XEU9RhmUVEp7uB9y0YTc9pnYFeqEMHzMyb1Vgnbm7bjBZPvFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oEUtcdpc;
	arc=none smtp.remote-ip=91.218.175.152
Received: from mta0.migadu.com (out-152.mta0.migadu.com [91.218.175.152])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EC8606A319
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 12:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2EC8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oEUtcdpc
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O0ZvGw0ZoKFzAZ1EP4MQE4G7MB6j6Lu1fMegrKdHYqw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792500548; v=1; x=1793105348;
 b=oEUtcdpcdk9esWoFxS2HUgXoj2xbr27DC60xMLZGGZFmXPL8YiZwHM+B/yNmyAzarE3ARB4O
 LzSToGH7VZtEp6FaCsEQ9+fbs+RBfgxqSrWKj1812CrIfpBFHXk+yT0+jHlHyyhVzsXqrUedkbV
 2tLqIadHyowX1RgLxDTzByCM=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 765e9563e2983e52;
	Tue, 20 Oct 2026 12:49:08 +0000
X-Mizu-Trace-ID: 765e9563e2983e52
X-Migadu-Flow: FLOW_OUT
Message-ID: <95c88c33-0184-4258-ac02-8eb42f346b36@linux.dev>
Date: Tue, 20 Oct 2026 20:49:03 +0800
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
Subject: Re: [PATCH] blk-mq: add direct dispatch support for mq-deadline
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-block@vger.kernel.org, Kaitao Cheng <chengkaitao@kylinos.cn>
References: <20261017105400.95967-1-kaitao.cheng@linux.dev>
 <307b05d7-16dd-493a-a10a-d5ac50ec219b@acm.org>
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <307b05d7-16dd-493a-a10a-d5ac50ec219b@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/10/17 22:19, Bart Van Assche 写道:
> On 10/17/26 3:54 AM, Kaitao Cheng wrote:
>> Bandwidth in MiB/s:
>>
>>    Workload        none    mq-deadline    my-patch
>>    jobs1-4k        1209           1047        1174
>>    jobs10-4k       2458            946        2349
>>    jobs1-32k       2568           2565        2562
> 
> Can I conclude from the above numbers that "none" performs
> better than "mq-deadline" and hence that it's better not to use
> and I/O scheduler rather than to complicate the mq-deadline source
> code?
> 
> I have removed the linux-doc and linux-kernel mailing lists from the
> Cc-list. Block layer patches should be posted on the linux-block mailing
> list only.
> 

I ran additional tests on both a SATA SSD and a SAS HDD. The results are
as follows:

    SATA SSD       none    mq-deadline    my-patch
    jobs1-4k        294            295         295
    jobs10-4k       133            400         401
    jobs1-32k       470            470         470

    SAS HDD        none    mq-deadline    my-patch
    jobs1-4k        218            218         218
    jobs10-4k      26.6           26.9        27.2
    jobs1-32k       225            224         224

The SAS HDD results show no clear performance differences. On the SATA SSD,
however, mq-deadline outperforms none, and my patch preserves mq-deadline's
performance. Together with the earlier NVMe SSD results, these results
suggest that the patch combines the benefits of both none and mq-deadline.

I also found in the NVMe SSD tests that disabling the direct dispatch paths
used with the none scheduler causes its performance to drop to the same
level as mq-deadline.

-- 
Thanks
Kaitao Cheng

