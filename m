Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE64FC339
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004408; cv=none; b=H2HUzDX3sBrfG0d32TNj3iMqGb0ipitZIZsUG7PBuReHbGapKyftF+njV7JJihfY7tfJim6a6vsiLcNCEgnLRkegrxIayC/Z3wz0Hop6ePXp4aag5LHmjoSKSKyuHdYdc96va5+E6N8yi3A6UMhEJ5GbvyPdDte9wItQjxzIypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004408; c=relaxed/simple;
	bh=Rb8XZmmvT8cxn74MXNUCeOuPGauZxlvtGCiTJh0eb40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBLiceOWZHaGcAGogP6/CAqCZe0uJhPksx+8dQZKYMV9kAqFjIk4sBB5IKCwXKJT+7Hwzcu5kBIDnhphckN108fj3Tr3wDNGvxaXEiadCi3k+LXfUqs8NUSRhaeiMXaFxcsmF2jHBglwiGOYy1zwG4H75YiGHGCuVjAeC8X/+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=mWWj+UUG; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=4R4wY8mh; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="mWWj+UUG";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="4R4wY8mh"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EInvhf2434962
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 15:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=SHv5
	vB/tk7sll8Kkk+NHhBijfzgb1pYQHOyGwy6N4aU=; b=mWWj+UUGvdXSLYjqGKBk
	qRjyZAFUBqKDFrBsJRjkInUs3ju9ynsaD1j6tJXOE3D0QkYUleR2qkiM6AT/S4pI
	vyObvXKzpUi43jFMC6RmvfwI/sftJiI+Hw4rC/jRdrGpIQEIu2NtmXyndK6GA255
	bd1juLQfEt+qjg448awRfj7cNjD53xF9l7L663bj54t/tGEbjs/hllrUIfkkgnbe
	BIUvzpNKtqm8z3t+iPKuTj9dC/dPMoTDtxhMJvHK7TRZqVaOLjqkSpyqJWILv2w8
	1B2EwMv2fuKSjN86b6U1uEvcoH3PsxtASiWjbYjlsZ+dOFtthToPQ0JdCQVlHupv
	rQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4ha7mu4hfy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 15:00:05 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9195c59ac8cso139958576d6.0
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792004404; x=1792609204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SHv5vB/tk7sll8Kkk+NHhBijfzgb1pYQHOyGwy6N4aU=;
        b=4R4wY8mh9P610BNk70s9WMqktgB4ygPldMkGPAbjEJVdD/D5MZ3CNaT4I3J2Uz7qsf
         F6AWmDoGtxF3OJitLvXm3vzBgd9/6e6dehEQxrdbdwj1Ecq3TA9n6E/Q37D+yMbl8tMW
         9OMhbR5RDvXVoAkwyLXdLrv+l7hGAW+olFCTBdKOcWhy6h1OUxMTcDJfmdJw7xDRZBRt
         pSFtYLo7C1Z7kfVoPSAuMc10vWIfiTu9yNG6f7VIIi3ZZcdj+7rgstDXlAM/nf9TPI3w
         C7InlKXs2QRNjpNsKHyPsdtpH2RhYzpTHftK6LtX5O0BNv43wMjXlJs1RUUUptoXFTAv
         SNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792004404; x=1792609204;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SHv5vB/tk7sll8Kkk+NHhBijfzgb1pYQHOyGwy6N4aU=;
        b=RAcdw7qcudKht39AZ0RPUkGCCaRRJWBjGf7cifzYaB2KaBr7NmH3JTyJ+LvyCGG/0q
         ZDcg1Sz2qYjKi/pEu1wpBacgcQ3ES52R1D1uu5kfyRynUGU1/tuvBHxuiiCQfPkrGJrr
         2DrISAxibClgZp+J85CAMt0kvFYPqv4REW861J9CFAK/HNTTRt3VfH4zVcYZXHhgcbAX
         3YyglfKkeB9ofuKqb9+hQgZ7B9NHnm/pBb8V+bpsGZbrkSINxHmfwKKesTcNuyHTuB8D
         Ft9POI2XgOIWgV7Ou1lXTGPsNyOC9i7KBdiWJfdhcA5qFpw1njW55MRWma1De+oeBsLx
         bygw==
X-Forwarded-Encrypted: i=1; AKwUvBwyjDNNYMuGoXTdml+ip+toGkgGzWhe/mJqt69lO2cukhPijz+IA8CA7LgWFG04q1BHUkucBi1wK8sxOg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIA0E+sYTM/IVmRR5E3/YEgDnJJHph9K3Bf4UVm98cqI5wgJYjJ
	uWctKUpVFIIf7wRnfz+RQTr2+6KFD7dI+fH8oVnjweaT0NDEDXXJYuX75+hO3AnnBTkAaj1YLWk
	BKWJ/DUN6AZUz4u18MUmec3P5q5Nj1zKQSWiSTi9HFsOR+xOk5tamNmYQp2JNrWLg9DLk
X-Gm-Gg: AYBFou0E7UaWNtoq6GATg2V687Giu6etgsIcGlEIKYmUUYKMkIHlDJ40ZwYR2gzepek
	t6NW5Uiykj0ctqIplZuvKN8x2lPdGjwLGkgcOBkywghBqByZbVWct/84mi/IqeMFr229JAcGmeW
	pdrBHIzoT4PlzzgoFkxiawdEvuzi4+cyfvvriHQY+TV34I1QxuZ8wEnWkzbe8gA/uXdYqqkT4BW
	EDMubEeUPBJR2KgFx2khT/FcNXunPAsfXgD/IMCe2Zb1gs0R7NI+Mo17i5NyAQTaLz63p05mG7+
	voIVuCeRQv9NAwmlbWLzPE/ct7vEs+/MJkiMwXPmuyZE5uw9DY/mznBxQqr+cDPsh1UObHzUppx
	dB5Z/NWXow24DXlweqRK1xtpf3+014MEe6OGkzgsbUjPCaskX
X-Received: by 2002:ad4:5c85:0:b0:91b:5d39:e12b with SMTP id 6a1803df08f44-91b5d39e8fcmr282066446d6.52.1792004403629;
        Wed, 14 Oct 2026 12:00:03 -0700 (PDT)
X-Received: by 2002:ad4:5c85:0:b0:91b:5d39:e12b with SMTP id 6a1803df08f44-91b5d39e8fcmr282065896d6.52.1792004403051;
        Wed, 14 Oct 2026 12:00:03 -0700 (PDT)
Received: from [10.207.9.0] (nat-128-59-176-148.net.columbia.edu. [128.59.176.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b3864dsm59747086d6.14.2026.10.14.12.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 12:00:02 -0700 (PDT)
Message-ID: <54a2b38f-f863-48dc-be26-b18949be337d@columbia.edu>
Date: Wed, 14 Oct 2026 15:00:01 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] block: fail a short atomic pin in
 bio_iov_iter_get_pages()
To: John Garry <john.garry@linux.dev>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Keith Busch <kbusch@kernel.org>, "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu>
 <20261009-blkdev-fixes-v6-5-307939c387df@columbia.edu>
 <82978d5c-3e08-48e9-bf0a-7913e1cd0507@linux.dev>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <82978d5c-3e08-48e9-bf0a-7913e1cd0507@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3NSBTYWx0ZWRfX2MQyqczPAMNM
 6Fo1ONar7nQeZUU2VZ0tuYHNSH0MRWMVClYI4ghIOBT0Idj7MyQsuvZW2wg6zR5x7GegtauQd/T
 A2SkbEo8A7nP4SoGubcCKLrc4ySLvaVNyPu/UocmlSocx+8hH02h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3NSBTYWx0ZWRfX5zr5HTBp8ZV7
 tW93VQJDGPUeZacab61hGFQ1DpAs0QyKvL1c9s1JNcYG19lMO3pjKDdiptl4WnE7KHCTZ0B1Fl3
 rVARp3z87W/Ujg6jxzZKWB2Yikvrr0J+qVoeoq5kdlNo7hPiY90WF4mUfVF1qMhuATRQGK7gHeb
 jtcAIsAmLMpRSLIdaFCobt6MN+LG46tUOrb5rkRW2NTP3P0lao9iDb53u69LMf8Z5NW58RHItjJ
 HAXJ5aG0ih6Id377Qw7Pw5Ko80Uu5RSRV/CdJRWoCgXvw9BRDaDdgokm0HfAtChbW6vVWGNE/8f
 h/eUJptVU0h+QtMB0CBkTuT/MvPp92m/ZW1aDsF2h6ZqVREsdqA9mTm9JOulKjW2CbTjSpOzflq
 T3nhIJ7mWN9HcuLYs1zEqktK5LGyiD2DAyMjsP3HvZksGTg97VV27xdggF1kYj9PdQDtZBjTgle
 TNXzRog5fOuZXp7AfHA==
X-Proofpoint-ORIG-GUID: gU98bmHqO_izA0_rYFFTrtGSAtfKXi8c
X-Authority-Analysis: v=2.4 cv=RO8mjIi+ c=1 sm=1 tr=0 ts=6acfd135 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=dxtdfZqDOO0kCslK4e47hQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=p2SREvNk3m13K0H494MA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: gU98bmHqO_izA0_rYFFTrtGSAtfKXi8c
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11935
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 phishscore=0 malwarescore=0 lowpriorityscore=10
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 bulkscore=10
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140075

On 10/13/26 4:40 AM, John Garry wrote:
> I think that you can now remove the REQ_ATOMIC check after the
> iomap_dio_bio_iter_one() -> bio_iov_iter_get_pages() call also; however,
> considering the trees, it's better to wait until 7.4-rc1 is released.
> 
> Thanks,
> John
> 

Sounds good, I'll queue that up for post-merge window.

Thanks,
Tal
