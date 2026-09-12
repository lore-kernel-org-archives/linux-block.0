Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CAA36A37E
	for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789204789; cv=none; b=f2e3LN4ipQyt9kqcJucj4wt07xvJNE21rAKoKEy+SOMikkgiMpD/RbMI4TkIee1fK/XtyJ/DVUfWetOhpRH4XjEUYzhjb9LSvSxjgRw9u9B1HoMWcf22ajXqF+ttUIt6jjkIvtkjGE5US6yGQvdyguNBv25Mw1eZvU2pmNSA6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789204789; c=relaxed/simple;
	bh=iofOTXYS/bZXZ/2qBa9da7ho8/2GhtalFO00MODtkb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+TfxZ9g6jMyrP8iHt/jAUCkXw70lS3inSVvo83S5Zbjl73j2zX7YE02lypArEFBv7Sar+PNdDzHbzO+f0j93Lla5sn7YHqBzSUW2NbptsUslChOOBrbSxpbvvjHo1k7SRv57pbw3nazmIXtRxsqaLbikmQO1oW3vKSfAIFbqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BGFupaJx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XN2G9PPa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BGFupaJx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XN2G9PPa"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68C853Ni3019671
	for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 09:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/33vb3qfO68qBBPyyf3BMf9vXtG4LUI2mzvFC7b6Ls4=; b=BGFupaJxsCp5Ahs+
	68qLTg/6wTbeLOGtIp0K/hgIDt2VlrkNoNpZVWP8g3v1YaU2GFYI+Whcz/Qxq3pm
	lIE73ZUFRwkK4ItPiGl93YsomUcKszTDx4uzwBFnLAzEl9tm4scTPzpZZLtxQZlM
	Js8aqyGz4LsMn5J50cWVx57moU8R4JIlv2Hi9eQ9jfYXSW6rxgIyBIbIDGHaM2yn
	VvIruPB4o+KYtcpIjE+2OCxEulyQwOeXN3XgfIHItCtLyzyLvdPm+iYVOM8dOkMU
	A+E0WG1v0Ttg+N9+BnEnPaUnPXmNk64rTBy5IijJlB7yNHMyzfsCtGhZASjLeirK
	kxiWoQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dgjyj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 09:19:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6fed0652bso18880425ad.2
        for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789204785; x=1789809585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/33vb3qfO68qBBPyyf3BMf9vXtG4LUI2mzvFC7b6Ls4=;
        b=XN2G9PPaHg0WzARB29b89jUiz2+ka44gETZH9dUrz9h8eMl1PFosvI9loMR1W++HC3
         tZGC4KQelTCDxK70ac2lIhDpzmZo675pltnLljxzjaNzP8MEhaolVnNTbqHO1HWtgPXb
         +siW434bNnABeUJbWod7b+oLZ4AjLbw5bIR9wPcXjQGLZPjT+urE4z/tPlMMRmyStEaY
         ov9Q1TU6u6rcT/VN9D7cXAGnRBvQwioMK78+2GOLwp8njYi+VZmiSUrVWz5ViZQUWx/d
         J9kzg4e7RaNIYMur/ZH1jNTXSA8Jpx6xFimdru7omM2YVvvcCPfX3WtxCu5HR/53sTvI
         7ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789204785; x=1789809585;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/33vb3qfO68qBBPyyf3BMf9vXtG4LUI2mzvFC7b6Ls4=;
        b=X/+yXBQC9yDQwqajFnxj+RHb3bN+dqg8242QrdSHN7DparCjt8Yvaj7+rGfn7yFVt4
         S6VchEMTY1ou+TknmaI7u9I+Qt6o9NAXSWjhiZwGybXRHuy8JTKM1CWtforxqk3FWGMw
         icq2esEeEbi4929ooRvPxPJ8gsnTE9wgrA+bs1EZq+bPtk5MSjY9W0LhKkvXO+Fj/E4e
         129XsLAnOLy9gX1aT5Nr4lh8pm2s2zY7cHSt+1lYWHnE6axtDtLg7TtQtKXWOWW/F8w7
         thzvj5Jn+ep/MmKh40o8JiavO/fgBBStfbQP/yEwpoUxvwk4TFm1laHnjl5Oalk1WaIK
         svFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRbppZoJ0ft/0XxMQSlwgFrzTm9qFk+w4cn7FYPJzEkc+SUW2OSIxxhSdBFDTbBTmZfNuogXBQPTwp5g==@vger.kernel.org
X-Gm-Message-State: AFuF++lUzlXXNDro47KVFaWtIr0aU06YB2FpZpCZWbhl6wIw37+43Tnh
	pUriCHrKzm9ygVV0FkubTgy5UYiK04ytAq+HZzJe0gw+fY5GY0goF1cQgmvMavCups2fKYAvKfj
	+mEpbrCEmI2AsLYXWGwu25nVDkDUBCLNq+x5WzZUc0NcDELnrbFmTRxH2Xtz8acDHPQ==
X-Gm-Gg: AYBFou23rQu5sD3G9RLXMLZqOmIc6fUDHQnX/bnxPhIa71SGaOB6bWe1vYBO0GdiJnf
	wemwmMa+hMAvfgN34GUFrKSQ61Nob3MrO/942fghIZ2X6iPNYspJZWijRDQEuql0Dy2TX+V3usv
	3zpdP/twYzar/DtTFpqf+MU2zYiecnTaWsgdwdi2+pl+ui1SH8r9g+lN7iPsrBmruyu8EWFI5BV
	DVKGn2Vo+0/CdOmLN/+DDr84a2vv0v2lSPM3VnGica0iHsaCSatdW6S8QM7wV8Kk0W7t1xJdH7l
	WQojObHqSvyptciOZBxFu07GsHAznoqSnpjil/4CglEmX1MwveubOMwxp0K62uwFbluzsvWC/aa
	EhpkZG+BktIst9jiLrOLu5lVWsybnqEngErV58+MsbcR69Sj49JJkqH8AdDlJjNi37t8Z
X-Received: by 2002:a17:902:f685:b0:2dd:3ddf:b895 with SMTP id d9443c01a7336-2dd3ddfbaa5mr83347555ad.3.1789204785443;
        Sat, 12 Sep 2026 02:19:45 -0700 (PDT)
X-Received: by 2002:a17:902:f685:b0:2dd:3ddf:b895 with SMTP id d9443c01a7336-2dd3ddfbaa5mr83347155ad.3.1789204784987;
        Sat, 12 Sep 2026 02:19:44 -0700 (PDT)
Received: from [10.249.16.182] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca268csm22228795ad.1.2026.09.12.02.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 02:19:44 -0700 (PDT)
Message-ID: <06aa40f1-9a47-46e0-88f5-43ece4e3160c@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 17:19:40 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3LcahiUL4F9RpsLnVgaUNoF3kM9ZQj4h
X-Proofpoint-ORIG-GUID: 3LcahiUL4F9RpsLnVgaUNoF3kM9ZQj4h
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa51932 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tUvm9EZT49aG8J7fJHcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDEzMyBTYWx0ZWRfXwNBZdK5+4SQp
 0onYlph8pnBg1uof+JoQxjpOf4YKj1MsYZcfGqtxqm+jWW7OSIZbRvouQUxoAR/A/F5Q5UiXIxq
 j8N54I3Bn2XAQb+XgM3gmL7iKUUyPao=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDEzMyBTYWx0ZWRfX6YrWLtHtVm4k
 HMMn/g3qhoAOxyCEJq0ByDSms0BXqjPny6Rf9qXsgt64r1aRYuNWNz5IZ33unKMbVSHCsEkHv01
 eNgp9uMECffb51V1AVfHOIvXffAf4hw314q5Guchvn9RMF/qDks9Bkqs474dLWWvylyufMseVyg
 0Arr7W/Xj7tG449cjA3Zoq4r8ctL66f76WOHIvjmw/gCJPDqoHvXbEWjmEkKk4iDLoSRR9bYr1W
 ZOhqu22/MCuLZszv429GUSbIDuBwQiD9ZtRI6tImdNIJEKHNSaaQfDKpZvah/pxNyO4M/75yzgo
 s3YAVBSjYIar19C6lpTEYe7YG/qt2RpG6i0r7sVSsWSCY0l/J6yoS3khViPbSj/5Dq5WRjPEx7r
 l6LWmIkO01abd5Qg8TUDoxOkiSgGAYgAJ4T0R7vR79HHxgJ2tjgLp+6sdKWoxI/gc8EsbkemO3+
 LWkU7lmL/lps4ETGM2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_03,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120133

On 9/12/2026 4:52 PM, Cong Zhang wrote:
> Replace blk_mq_quiesce_queue_nowait() with blk_mq_quiesce_queue() in
> virtblk_freeze_priv().
> 
> Keep the existing freeze and unfreeze order. The synchronous call waits
> for dispatch code that was already running. The queue remains quiesced
> until virtblk_restore_priv() calls blk_mq_unquiesce_queue().
> 
> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")
> 
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
>
Just noticed that I forget to add the ack tag, sorry about that.
>
> ---
> blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
> blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
> while the flag is clear. It can then be preempted before it gets a
> request. At that time, it has no queue usage reference, so
> blk_mq_freeze_queue() does not wait for it.
> 
> virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
> blk_mq_unfreeze_queue(). A new request can enter the queue. The old
> dispatcher can run again, use its old flag check, get the new request,
> and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
> reset the device, delete the virtqueues, and free vblk->vqs. The old
> dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
> kernel can crash.
> ---
> Changes in v2:
> - Cc stable@vger.kernel.org.
> - Link to v1: https://lore.kernel.org/20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..7a570591e040 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1595,7 +1595,7 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
>  
>  	/* Ensure no requests in virtqueues before deleting vqs. */
>  	memflags = blk_mq_freeze_queue(q);
> -	blk_mq_quiesce_queue_nowait(q);
> +	blk_mq_quiesce_queue(q);
>  	blk_mq_unfreeze_queue(q, memflags);
>  
>  	/* Ensure we don't receive any more interrupts */
> 
> ---
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
> change-id: 20260910-virtblk_sync_quiesce-9b2c88d45416
> 
> Best regards,
> --  
> Cong Zhang <cong.zhang@oss.qualcomm.com>
> 

