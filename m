Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9938F931
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491840; cv=none; b=b3BDxKzFv5yRMr0KfJauFTsdpgHpmhYDBy4BFbhYoaLNj1xuo7NS0DEAqCXSCjtqrj4PDOxkg6+oSYh53DUVNDfN39DZvDNyYUC1HumjlB++LCGF1xDJpqiFmRLm/qM3bgCJzU6fJmONryOnrM5FiS7Vi8gRUWDqp7/s+1xR/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491840; c=relaxed/simple;
	bh=4g38+1lKxMMFXNGYi+/tGlmbD39J/6oFSR8yf9ZHHoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWkrPyngq2W6BYPL9cicg7F9Y7cJaerr4OPPz9IRgW3FUeUhh3w69INlqCUazu6nlp/YB5XDX2iecHqd+HaWsd5tyxZG1WGm0Kp3TTTw4yadXnH0bzprgaZSZaUCcuGjOKEuTK0dfgup4+hOutA7JGZaefvypX6FsFCI98GPFVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=QCzNXMoc; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="QCzNXMoc"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MMSaZL2789975
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 19:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=XolI
	xwfsVJBVBpTPhnOybhIeNs+9oP88EwbFpg7C0dI=; b=QCzNXMocAxNFTmwB5r82
	Iqr6KeBeNApgLe1JbrJXqMTH7Hv0Jt/WD3PXKZ/QXCCaHxNZnn7Cil8P0gyKLaZv
	DWa07xsv7CrqPRbXnIU40NAL0kpe5neyU5MB0D0nSvHNPjBZq1at98019jHZbOE3
	9g6gkdgK+gyYrvYu1WCQVHRC1VK7MVRiBOCNXxobfa1CXAaZYTlihRJo2JKZpq8E
	AI1jZOOmEZE6eGOhYGuOC2N/WUrRf67sQd7RyFsswLHPrLlCbfd44HeFHwp6RxpT
	j8T6/BvDioIehEh0yVkyfu3Y4ybyW3Q/KGibGcM/+R8a2gbWyj/1VhE1uhi2jsxH
	Mg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4eatyqae41-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 19:17:18 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516da5a1db4so26207151cf.0
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 16:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779491837; x=1780096637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XolIxwfsVJBVBpTPhnOybhIeNs+9oP88EwbFpg7C0dI=;
        b=fOBgiSAk1x8EINCUsWEHy+P/sMG9PocJvV62VxQfHTdCmcok48pvRX3cOBDsFs7XHN
         MAI9GedWW9c18bRS/1URvZGkxuREbF/mmykg/NWiYqSk7l5uNXsshZdtd0ZZipqBXl5K
         0JYYVuOZV/WvCO8mO1MwJ9koqBR8ZAzAIlgbG4DGC7M2RfDskKTJGvfjsgG2ZnngfmxV
         EeG8Hnxm1s8BN4lxeE0+QZwaThRdR//yygX+sJaVYV518B24rRwjhp6PpBqGBsBEuEz0
         M5x9IqXeyRvxTpJEyjqT4Ij9DxDY677nDOQod3cC+BymHxwC+NsEyDlxnvqtfteHQBdq
         TAPw==
X-Forwarded-Encrypted: i=1; AFNElJ8z/XwDiygsO7fyQgZAZLhk4fYy9P3FwkpxDnxPI4Y1nmfmXK1NpZkcu+AJOyGdqw7bHpSqPf7Zu5BnSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAVOaWPpySpfX4NlceNZinxlozDrshpKRdoemn7xNWr2qaMFJF
	ZRT++spaE5I/nVPqVqromZisNymd2CTtw/dM81nWHFdMddj/YJeZx6B7xpuPiz2LqnU4aNnvLV/
	bEW7ZGH4qN2epAqa5h3WF1QNJ7l2hK2GfOT6HLOcw960yH7o84gzqeKCkkvBd
X-Gm-Gg: Acq92OG1KPNMthriESEjOhWzzA8O7ypZfpHZ/D6TayOli0J8ElsxNthUXPJ8sN+r93q
	JcUH0XWNJxTxbT9Oamcm3fdTPJrUKeJDKQ+gyJob42HEDRWKGvXQNeWvEryxc1SvZlwXkdG7H+0
	ga+UriMt7TWfzGJjTWkb1kcuc1kXC1geUY6muUnisgWtKZyxEk/+id9JgVpBMCkw4SWUUxBQGud
	YlIrMNBZepZJLpl8nTw2DLMCIilX7r1HXuwywkTX3Fa2oN41+jwqCBpCx9DvpJzQ322MYF+Iuq5
	emxsBBF2G3gZ9RDo1R1eyJDr+miX8SiGZSOONMg8upMcvETyQ1ahhIlSgcSxAKVeSjiAmkhyVY4
	nYNor3l+WG8s33RVk0v4JIf+V5BBuRQmeuipCkj9vF/l+vHbazrKGCCgxrVulqGqUdjZzfVW4Ts
	c=
X-Received: by 2002:ac8:58cd:0:b0:516:d8c6:3e64 with SMTP id d75a77b69052e-516d8c6436fmr59502341cf.53.1779491837053;
        Fri, 22 May 2026 16:17:17 -0700 (PDT)
X-Received: by 2002:ac8:58cd:0:b0:516:d8c6:3e64 with SMTP id d75a77b69052e-516d8c6436fmr59501831cf.53.1779491836515;
        Fri, 22 May 2026 16:17:16 -0700 (PDT)
Received: from [10.207.65.224] (nat-128-59-177-214.net.columbia.edu. [128.59.177.214])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b0065asm25972531cf.2.2026.05.22.16.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 16:17:16 -0700 (PDT)
Message-ID: <f8d509c7-c0c0-4196-9a82-a6f8ae24ffc2@columbia.edu>
Date: Fri, 22 May 2026 19:17:15 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] block: enable RWF_DONTCACHE for block devices
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Gao Xiang <xiang@kernel.org>
References: <20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu>
 <20260514-blk-dontcache-v6-4-782e2fa7477b@columbia.edu>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260514-blk-dontcache-v6-4-782e2fa7477b@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzMiBTYWx0ZWRfX7MWJKwZlWJjk
 MOaexB7yy0+c0jmBUxBL1SK8BhCrX+Ncv8Km99HJybPgV5K+vHCMsm5+K6zss8WrAJIT2C74A/Z
 yPTfSGvtHSftcVthv5VutuRX9qX5PQ+lTjjdVYpKV+K1euQGegU0zpTdMyCGft1Gz4pyqltbTms
 vZkuWCrPfp8gqKI1aZX+7yBNZSJm7Rt+eClyr9Fw9VT6u26JvkK+OrGo3ZwEnlgDAR7rMaAZyD5
 yimTcZh9XyiasmcMab1LtBQaaG6u67MKjvZakza4gN7azmBurBmLOcep/xtt4snRRmPM0aaLlcS
 kD9f0uUSl7vnym+r7bxdhfg9KULUQfJT/oeIJS0RU5St7HY7JtBebAcmtyUoTylCAWyWYkBadfq
 Nx7LhHjQ+dws83ngp4L8Ohm8bkR4XA+jB53wvNqjhFRvlDvYTVJo5g/zX560QFCmaWbYCQfUjGg
 HMm5WypXFq2NuRJDuCA==
X-Proofpoint-GUID: Lg9pUkkvrMZWxKc5U39idHlJw380v5fX
X-Proofpoint-ORIG-GUID: Lg9pUkkvrMZWxKc5U39idHlJw380v5fX
X-Authority-Analysis: v=2.4 cv=QYJWeMbv c=1 sm=1 tr=0 ts=6a10e3fe cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=n4JpGxNP30DHW88kdRRHAg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=c92rfblmAAAA:8 a=7QGR7LCADlPcIrvLOjwA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11794
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=10 phishscore=0
 lowpriorityscore=10 clxscore=1015 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220232

On 5/14/26 5:51 PM, Tal Zussman wrote:
> Block device buffered reads and writes already pass through
> filemap_read() and iomap_file_buffered_write() respectively, both of
> which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
> by setting FOP_DONTCACHE in def_blk_fops.
> 
> For CONFIG_BUFFER_HEAD=y paths, use block_write_begin_iocb() in
> blkdev_write_begin() to thread the kiocb through so that buffer_head
> writeback gets dropbehind support.
> 
> CONFIG_BUFFER_HEAD=n paths are handled by the previously added iomap
> BIO_COMPLETE_IN_TASK support.
> 
> This support is useful for databases that operate on raw block devices,
> among other userspace applications.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Responding to Sashiko review inline:

Link: https://sashiko.dev/#/patchset/20260514-blk-dontcache-v6-0-782e2fa7477b%40columbia.edu

Q: "Could this code path be unreachable during block device writes?
Block device buffered writes use blkdev_write_iter(), which unconditionally
delegates to blkdev_buffered_write() and subsequently
iomap_file_buffered_write(). The iomap infrastructure bypasses the legacy
address_space_operations .write_begin method.
During a write, iomap_write_begin() handles buffer head allocation internally
by calling __block_write_begin_int() directly. This naturally inherits the
FGP_DONTCACHE flag passed down from the kiocb via iomap_get_folio().
If the VFS write paths were actually calling .write_begin for block devices, a
CONFIG_BUFFER_HEAD=n kernel would crash with a NULL pointer dereference since
def_blk_aops does not define .write_begin or .write_end in that configuration."

A: So this actually seems legit... doesn't look like anything actually calls 
blkdev_write_begin() or blkdev_write_end(), unless I'm missing something.
block_write_begin_iocb() usage seems necessary for bh-based filesystems, but
block devices seem to use iomap for writes unconditionally.

> ---
>  block/fops.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index bb6642b45937..31b073181d87 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -504,7 +504,8 @@ static int blkdev_write_begin(const struct kiocb *iocb,
>  			      unsigned len, struct folio **foliop,
>  			      void **fsdata)
>  {
> -	return block_write_begin(mapping, pos, len, foliop, blkdev_get_block);
> +	return block_write_begin_iocb(iocb, mapping, pos, len, foliop,
> +				     blkdev_get_block);
>  }
>  
>  static int blkdev_write_end(const struct kiocb *iocb,
> @@ -966,7 +967,7 @@ const struct file_operations def_blk_fops = {
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= blkdev_fallocate,
>  	.uring_cmd	= blkdev_uring_cmd,
> -	.fop_flags	= FOP_BUFFER_RASYNC,
> +	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
>  };
>  
>  static __init int blkdev_init(void)
> 

