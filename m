Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F047C1373
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 01:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717636144; cv=none; b=k81CsiasoRgHJ3QzkizhQprSIRPyTm/JftGJwxpwEH4aIuspyf2k0JWDvYNW6by3zGZSpWaXOo+xfzwtbt21618hOH669/Upj4fv6ddD3iZKp/O5cvA10BMuTKbW9CYFQDngwnrVZnKrNJWzG2PcRs5veQU3oschboFpFE8yyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717636144; c=relaxed/simple;
	bh=WOwjFkABDSkF67Cfn91JPyWJhJHHMkC7rJpl1Vbtzug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=GTC2KVBtUB8gn8IPkrpDD4D9sOwi7zAnh9TqqMsTewLxzLTaqjEQbO0KgPVgPNCs8zxB/MhW230okToYFZuIRLeAIQ01AZIYL9D/BYGbx7wcxvJdpicxnYeQPkd9eiaxal4I5IMXQuqP21tRFGtB6nSzGf5rbzfY371lpC/hc4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZIgN7cxN; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZIgN7cxN"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240606010854epoutp03dc8a5eb4ce0554ad68dfdf27f7cfbd43~WRPa-mGn40745207452epoutp03p
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 01:08:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240606010854epoutp03dc8a5eb4ce0554ad68dfdf27f7cfbd43~WRPa-mGn40745207452epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717636134;
	bh=DyJq680hs+B+mq6sTVl9ih/9wYgktdGjE6kStgD7w08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZIgN7cxNkIAB3VLSBJ8SYZAQUfgaM6BtzYwZI8p8A1/KDD9Go5QIXPY3zqTeYmVuV
	 NXAGKrKDfwKOx27VrSJB7KQv5fTctRmCSdkkByVDRSoUvmIhwPTHZOB7zxs0ud1CuR
	 HpCi60T8AhkdSKDZtAB/8Mnh5rYdYmyLctpYq4gs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240606010854epcas5p20bf2fe2a5e44ed011503953503539e67~WRPasaZqh1759917599epcas5p2o;
	Thu,  6 Jun 2024 01:08:54 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VvmS441vyz4x9Q3; Thu,  6 Jun
	2024 01:08:52 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	69.3C.10035.42C01666; Thu,  6 Jun 2024 10:08:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240605090147epcas5p243e0e3fa55f586adf5f6c2e539a6d9fc~WEDBbCZBd3227032270epcas5p2z;
	Wed,  5 Jun 2024 09:01:47 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240605090147epsmtrp21f023cfc18084f69a4050032542406fb~WEDBaMj2t1583515835epsmtrp2h;
	Wed,  5 Jun 2024 09:01:47 +0000 (GMT)
X-AuditID: b6c32a4b-8afff70000002733-a0-66610c246d37
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8C.5B.08622.B7920666; Wed,  5 Jun 2024 18:01:47 +0900 (KST)
Received: from testpc11818.samsungds.net (unknown [109.105.118.18]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240605090147epsmtip1f215549f44d48ac600e2f28f5332455d~WEDAudVSF2721427214epsmtip1i;
	Wed,  5 Jun 2024 09:01:46 +0000 (GMT)
From: hexue <xue01.he@samsung.com>
To: hch@infradead.org
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] block: Avoid polling configuration errors
Date: Wed,  5 Jun 2024 17:01:40 +0800
Message-Id: <20240605090141.3873159-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZlrQCaR6xEaghWdQ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTXVeFJzHNYMU0WYvVd/vZLE5PWMRk
	8av7LqPF3lvaFpd3zWGzODvhA6sDm8fmFVoel8+WevRtWcXo8XmTXABLVLZNRmpiSmqRQmpe
	cn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBmJYWyxJxSoFBAYnGxkr6d
	TVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2RucF1YLLnBVb535h
	amC8x97FyMEhIWAicXqBXhcjF4eQwG5Giafrj7JAOJ8YJXZuXcgM4XxjlGj8f52pi5ETrGPL
	671MEIm9jBL7/z1nhHB+MEp8332dBaSKTUBJYv+WD4wgtoiAqMS96VfAbGaBAImGzmdgNcIC
	ThIv5hwHm8oioCrxaNFDsDivgLXE3TN3GSG2yUvc7NrPDGJzCuhKXDo9jw2iRlDi5MwnLBAz
	5SWat85mhqi/xC7xcrIvxG8uEn9OlUKEhSVeHd/CDmFLSXx+t5cNws6XmPx9PdSqGol1m9+x
	QNjWEv+u7GEBGcMsoCmxfpc+RFhWYuqpdUwQW/kken8/gYYJr8SOeTC2ksSSIyugRkpI/J6w
	iBXC9pC40ruVHRJUDYwS82+/ZprAqDALyTezkHwzC2H1AkbmVYySqQXFuempxaYFxnmp5fAo
	Ts7P3cQITopa3jsYHz34oHeIkYmD8RCjBAezkgivX3F8mhBvSmJlVWpRfnxRaU5q8SFGU2Bw
	T2SWEk3OB6blvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamHi8
	I7/bcFxfErDy5+UqXZfvu2Zn68o+Tjm4walkwh7xDvEblltkalLdZrKG77J+3+1+tZ3pZPlR
	mcuZh7Nu/tFovG13+x6f4kQzTv0LabIpKT9rQm7uW1XqUGanFuvWWvZHVCTHkWV/97KN0lYT
	jRT884NuPPxtXr7Ff/uTD5d/d/Zt/lsdteuQUE/2xedNuS1NGx1+t36TeDFBMOBd4wYNJ0GP
	k7p+XAufzj3noSb4/4e/wzZNrk8dctrNUfHreRYodllkzBS9cVN7f4KFxPblGr/e3phe4pX1
	64TbITP/ZetMjiV4CQYsqVetm3BtkV+5p8Db/ZE+b4pZDnLtr9DL+uC9sbtr442iAvaLSizF
	GYmGWsxFxYkArT51phMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSnG61ZkKawbKF6har7/azWZyesIjJ
	4lf3XUaLvbe0LS7vmsNmcXbCB1YHNo/NK7Q8Lp8t9ejbsorR4/MmuQCWKC6blNSczLLUIn27
	BK6MzguqBZc5K7bO/cLUwHiPvYuRk0NCwERiy+u9TF2MXBxCArsZJfbuOMUEkZCQ2PHoDyuE
	LSyx8t9zsAYhgW+MEru2WYHYbAJKEvu3fGAEsUUERCXuTb8CZjMLBEl8WQgRFxZwkngx5zjY
	TBYBVYlHix6ygNi8AtYSd8/cZYSYLy9xs2s/M4jNKaArcen0PLYuRg6gXToSvV94IMoFJU7O
	fMICMV5eonnrbOYJjAKzkKRmIUktYGRaxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kR
	HLZaWjsY96z6oHeIkYmD8RCjBAezkgivX3F8mhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697
	U4QE0hNLUrNTUwtSi2CyTBycUg1MfNUCy/S/15Xq+ipZfbu5RK78j85Cp9s/i8pfpKfca1MM
	bv4jfSeupOD3X6G7yme6p6/xUwl93+q2WPdouG18hU+jotrOk8tfz3ycVHRsLiufiLIQk1Ji
	ifK2B4/Z41R/9Dza6GcRfvW2Q+8Whb4H80Vr9t5YovX13I5PVsZBzQ/jpv9dGuVaWJjyVp1l
	lrSY1D/v79yW3KEVb1bG9KuUTe+YxZwsdznBUc1yXdbam+vlpTz+i833vHLe6diTml/uH7ev
	rai5+uYVr+vitT+u7Or12G2xnUWOT+LvBtGuL2Ff1nr45Won+L33cC4y+3g3bGbSQq3Hm5KO
	bKlb/tPZLzo6syPm8vId156+YOJSYinOSDTUYi4qTgQAKdTRlsoCAAA=
X-CMS-MailID: 20240605090147epcas5p243e0e3fa55f586adf5f6c2e539a6d9fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240605090147epcas5p243e0e3fa55f586adf5f6c2e539a6d9fc
References: <ZlrQCaR6xEaghWdQ@infradead.org>
	<CGME20240605090147epcas5p243e0e3fa55f586adf5f6c2e539a6d9fc@epcas5p2.samsung.com>

On Sat, Jun 1, 2024 at 00:38:49 -0700, Christoph Hellwig wrote:
>On Fri, May 31, 2024 at 05:10:15PM +0800, hexue wrote:
>> Here's a misconfigured if application is doing polled IO
>> for devices that don't have a poll queue, the process will
>> continue to do syscall between user space and kernel space,
>> as in normal poll IO, CPU utilization will be 100%. IO actually
>> arrives through interruption.
>> 
>> This patch returns a signal that does not support the operation
>> when the underlying device does not have a poll queue, avoiding
>> performance and CPU simultaneous loss.
>
>This feels like the wrong place to check for this.
>
>As we've dropped synchronous polling we now only support
>thead based polling, right now only through io_uring.
>
>So we need to ensure REQ_POLLED doesn't even get set for any
>other I/O.

Sorry I'm not entirely clear on the impact of REQ_POLLED in this context.
I searched that REQ_POLLED is set for request if polled in io_uring or
io_uring_cmd, but here we just judge the state of request_queue.

Do you mean making this judgment here may not be a good choice, because
it may affect other IO (by same path), and this change should be just
targeted at io_uring?

