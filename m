Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B035D46A60E
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147516; cv=none; b=bUmoK0NBRXtQFTu0YhnCAw9e7Fd/IwRmZ0fHzfsu2XlApCp33bw5c1sAvn6eUACdV2IkANPv6CG4ubAyNeCtlOfWEr0YGpZe6423jtZMMaijhy/aBAMO7ODLB2mwKjMwAWXTSMaN4ITL02gnWgvrbru3jsppyAceYRpOazuQeGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147516; c=relaxed/simple;
	bh=za3xPCzkeb/HbtLkfxowaJK9cwklSa6k6bFi2PQWCX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdMtyZ7bsfC+gUZDTl7s4r5+GBjpTF7rZXaaInSFeNKUAMacWCV7OrF3x4IZxBJJd+cGMA1MsmGqCKJfBoWDuefEtSvE/lCXH9OiaDVAW7awY3IRZGlp0bblgTxA5lszHjDlWrFYLClSlq225vMS0JZXlPNb+P0+JHYIpM+byak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cqjC5hWj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JvoiwgQO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cqjC5hWj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JvoiwgQO"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAAUS61647969
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 10:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kXyFb2bWpRvXjn7PnLKNSg4kUzQ9j0D6sJu6sZHfQlA=; b=cqjC5hWjjuUoAN2r
	fUvmguEvQmzjUOru8VPNLlR0Zj/In6bXgvtGRAZaZE8XZUkxH62CRIAs0qVj5Nqy
	dYYzuzBg+munPZgSSPpYXfLVtoOxGrYsAUcUWCDd2AQHE1K3PL7ij4pv/if9XXDx
	pmRslDDUIVc38faPIZEiXeDJK/l5Fwae+R2t5PsDB+bHLPyIyOwBN3BZlCYMUF38
	mhyFamLnXVq7RGzqaxQkYRnz93kxqjtgXcMcjE2DFuoRkES+ndsTN+s8ZJBI1gO4
	dm0R6/cAcRdlsi+2gliSOOK9iX5+InZNJXU725jeoQIsN1PHnBAlk69+Bq0fP4yO
	qvFn7g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhumr4vd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 10:45:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-898fe16133eso2315170b3a.0
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 03:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792147511; x=1792752311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXyFb2bWpRvXjn7PnLKNSg4kUzQ9j0D6sJu6sZHfQlA=;
        b=JvoiwgQOB3hgsT/JnwYXPvjOW1rmGNrYeO83Nja4qhtyH077p1jPhzZwlDq+T43ykc
         L2X0Tk75+kbjZIwGaUyymbxRqFjkB7kMXSxGoWzxiwNlF6husk8HIX3MX63CKXDPdD4D
         RuB8fNPdiZQtNYP5IpuEmRTkLwNC10qEY/cT01tmiv+QwO95npRz7tHsy4IioTOiXPv1
         CTGFxQ31C9Owo3GSIvwsSlH6JaxRWVJjYa2pNHygKgsvkumHBmm0uP2X137ZvfEFBu/J
         OmGDezasUU2u/mroeGYZGn0fuG9/S8anzt6vZh56lf5mMfm1ywEMi2YmSBW9lLZSxHnZ
         naLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792147511; x=1792752311;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXyFb2bWpRvXjn7PnLKNSg4kUzQ9j0D6sJu6sZHfQlA=;
        b=dVzrtqC0MIiqxsuwa8H4iMpipOV0Ybzg3zPGDfBEXB6MII3Rt2LYeEMpwkURJBqGtx
         NL/u1ItCyw/ctHKjrfQpZBw3ZhmX5gybsn/450BviUbUt9T0pWqb596e5aXNrXYqgsse
         kO7c/FXU3YpkLsxBciZUondHQIOIHfhjPYCGsu3lJRc2GkoNSRnLRjWjMwcqc4SFIQec
         D/6NxayeMKr2LzXa0rd14dXOSl1C70oe5yT6RyDlmJdVQePcpZWHuDO/HdaiABTVOt11
         PAcDQ1tdQkxNVYLxe7qCZkbpZTQG7C6tNs4H6JZtz8mO1/h1eUjEvMIsylPJsWDDIFtI
         NwgQ==
X-Forwarded-Encrypted: i=1; AKwUvBy2dDAwD1xI/bR5DkSVxalJasVLDT73xY+sGR8FLgKzsT9k0cGdxZmTnnZtyU6OS53ZqDXrzydnNXfYkg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLc9TWS/R7cdg3vVkLIZ290ZtuftZKwYiKipi005CjYsm2SLOxD
	2rVt4cy99kXhncO5Sczzxq5C8mgiMciaY9tE4rh0g7Bpj32vGbSn6QVLzrpAIce9S1Epv4j4epL
	MEIq9IpYK+Uqwvl+NoiyVQVb3zs93x1xZ7tna5kKf/JzJdiiwNbAHALujOEYYxtBSLw==
X-Gm-Gg: AYBFou3X/iaetrDxPVi4R1C0Xs4lkHSDKp3Afd/jP0WQCfeDGXoRtxv/s9pF/9YVoBk
	siGe6VhA09rFF2iKCoM8SGJ8HUEo29/Dcy7oLAjhaQKLjf6OBNo/ZR8Q1N6TXtoNyo8DrXmJYmq
	2tdyZgRHoAOQGm4dDSywulVluFd7O6xTRYStEg8RccdC9HA3DqByT821/uajzRYPEwwWQODzBt2
	HUyTi7OpWOqAhIvN7g0GVYY8zP69Q2fPJTf3IOjQRcmYD5XVnu5qJo+p5Q5qHMrj1bumAINxdSi
	OI/ORUHHJcY1GfnVu/1aXaCjzT0F+z/iumJ0hKf2Rni/QYklsrei4ViQQPNvu1KBBg+P5lTC0o3
	nhG7ujY6Bq6skFLXFJt7KEtj/tXM=
X-Received: by 2002:a05:6a00:ac89:b0:89f:3f60:cd81 with SMTP id d2e1a72fcca58-89f3f60dd06mr2297217b3a.51.1792147511401;
        Fri, 16 Oct 2026 03:45:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:ac89:b0:89f:3f60:cd81 with SMTP id d2e1a72fcca58-89f3f60dd06mr2297188b3a.51.1792147510877;
        Fri, 16 Oct 2026 03:45:10 -0700 (PDT)
Received: from [10.239.132.237] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57947fb2sm911384b3a.37.2026.10.16.03.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 03:45:10 -0700 (PDT)
Message-ID: <c02ffaa1-88ad-4fc7-9171-f8eef64f9ea9@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 18:45:05 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        Eugenio Perez <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260928-virtblk_sync_quiesce-v3-1-a037e6e2fdf5@oss.qualcomm.com>
Content-Language: en-US
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
In-Reply-To: <20260928-virtblk_sync_quiesce-v3-1-a037e6e2fdf5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX5xxXRyGZpalW
 NW0hcosH85FGVX9ZaOVW4C5ijcCqAuN+Y8yVsjFbfucA/nwrCEzLyQq4+MWWEDaK3wkIFprELlK
 xFeWYasoKiG/Kd+26OFxbWq81vuFux4=
X-Authority-Analysis: v=2.4 cv=H+BOUOYi c=1 sm=1 tr=0 ts=6ad20038 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=BM0rjV1Hin7eb0uZrgEA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: zD-DJTF-2mbyKVZxXeH_fzpp6TLnsut_
X-Proofpoint-ORIG-GUID: zD-DJTF-2mbyKVZxXeH_fzpp6TLnsut_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX3RcjVyv7thVK
 NNTVclTn0zkWhGPWrwNdmXAtTAVu/Ei6SMdrs0E4GAzXH/cN5UU805jkZLiQ1P9ryqVUif9imz0
 gzDRNTKbaca25gMfGsjfo4hh1PzD3qq+hD6mJwE1fV2o8YJktzcBvwSQyTw1Tz/5F8Tt+1zgnUR
 Pggt1Kvk7pBHYgqkgdotxi9tFuprtC8yHazNdLeprNfIZjcVsJAjalRpTPTALGxMdrttKzJOAQZ
 Fb4qPcpZtGEsPKZeUspNRrZedCq+izagK2UPnwbO/wVqyfrdJ4flulTJZYy882KhEWOjIHECFbg
 mcPJ7mNHwDK+VxZz7q7KHKJfbMa4gBA+xaL33oL9W4pWXS1pt11Y4ERM+g+AArMs7nJoKJS+d03
 5umQKWu47annN6X13Ve6tQsbS+uEEPeNcIxW0Nip+F2uZ9Hj29nUxFqm0mUjJ5m4vGOkgPQXAGC
 glzdtVk7gWPYBgyb1kA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160042


Gentle reminder on this patch. Any feedback would be appreciated.

On 9/28/2026 7:58 PM, Cong Zhang wrote:
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
> 
> Fix this by using blk_mq_quiesce_queue(), which waits for dispatch code
> that was already running. Keep the existing freeze and unfreeze order.
> The queue remains quiesced until virtblk_restore_priv() calls
> blk_mq_unquiesce_queue().
> 
> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")
> Cc: stable@vger.kernel.org
> Acked-by: Jason Wang <jasowangio@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> ---
> Changes in v3:
> - Move the race description into the commit log.
> - Remove the blank line between tags.
> - Add Cc: stable@vger.kernel.org to the commit trailers.
> - Link to v2: https://lore.kernel.org/20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com
> 
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

