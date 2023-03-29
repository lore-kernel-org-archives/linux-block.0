Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC59AC6FD18
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 08:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjC2ISb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 04:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjC2IR7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 04:17:59 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24944229
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680077813; x=1711613813;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i1Av5v0IANfijJy7313HLD9w+ZztkoJqJ2yCebnr7tA=;
  b=e15y/E5MfqFfgR3NixsJgYL3Y6/HymV7iOPMGdgXjuqTlPMHRaGcElUI
   DrDT6H7DgXjqREn6R8iBBLTIPqec/gIAMi4Sd1yibsBhG4uDhd1yC/UOp
   REDegfvLMFoT7oZiwRrB4AT3uSdCIAfoVZpoQEv346FjAebx18a+5dEqk
   PPUgL6XgtXB2OaT0hdqCX3ziRzO2b58ieBVHYHkgzGN7eOzA75EWNhTr2
   hO7jvg9w8ZgKCIL+jjSl+DWXYiFGXF7xiNMYB4A74+OwGTDp/ZZwyb2Vn
   Orj0bbJSaAIRfpqJlHwVj7uRj5v+ph7IwAz+6kZlQoJe64WwqjKY5On1T
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="338843293"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 16:16:53 +0800
IronPort-SDR: kfuNJrQWTUJlqy1c1EkO3xDrrnedBCaYJSFCC/HkcneiX8QwMsfcR4MOVwsB6fMX11o+T/DbT5
 Ahv+2SfgNGfjRjTPOlAMP9KFZVsC5eT7fFA24TRTEd31jnMNEAWGAyI5uu1mo+skZ2p4PsdKu2
 q46F9DoVjy1foj+ndxWmH2SIBNO+7eH7GnDN4wG38pOPnf+54fGYRuV29n+HN3AgWoazF35f1P
 MBegQb0cHVqdZsdMp70gfYoH5/LZTJOKPCKTYJjVJDDDXfa8D+GLda8wCJes//FNv+2wDNmuYM
 Lvs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 00:33:02 -0700
IronPort-SDR: w1AyZx+W1a4ZBAnGdqrKdS1/WeqBAilT9OFY6XA9v+UE5zFA6/y1Ze5hUtcyexmAjl3ruw18K/
 G+rwkyFRbuUaCZkUsEnjIFDgtpIqY2n1fKCk46c4wcW/RBk/Pg6ZGQ8uBFFT6u8FuMOrd8FepS
 sPObs3f3B6UpnwqHnztM+a37XS/05hmSsB+V5EBhhjx00DODiKd1Y/7jMxBe6LJ+wsAmEbS6TH
 y/mbECrWYUjHZZZCCewC+XKNu8gqNL9u1jQJnhogfHezumxTHPCO8HTgkXqCAnA0u+mGiK5A0b
 Fxo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 01:16:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PmfXj0tKrz1RtVn
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 01:16:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680077811; x=1682669812; bh=i1Av5v0IANfijJy7313HLD9w+ZztkoJqJ2y
        Cebnr7tA=; b=gWqsCRnserwXaDL8ml5qgKO7pSyI1iw0bNbFdYwWZ1zYMaWzIRz
        jSOvxO8sT2yfl+tNydRUPiUDPAVyjelMrRyJ5NwEH4TQl8CmFDCceMaOu7sLM+4+
        aYR0Oa0xxMoNoPW1YgZDcySL2Hw4r1JaZBPEjCIlsrQuKcg2SdPb6w58TQIT2aCt
        wEh8j2USfrIphoM/UERtqnyrypwjoppPg8YWoML1nbLANCnSmGUJkjrFVIbeKJRC
        yRMxEXk/ltSkZyIPyZJF4+Dpp984AepsWgemgNUHZgyvaP5fbezWllWaZXF7MulS
        nbEtKKWId4kxhABlY5owjQE2GrGILg2jzgA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8e_b_AGT7KVE for <linux-block@vger.kernel.org>;
        Wed, 29 Mar 2023 01:16:51 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PmfXf49tHz1RtVm;
        Wed, 29 Mar 2023 01:16:50 -0700 (PDT)
Message-ID: <0517910b-5acf-be28-24de-d7616de8a7fc@opensource.wdc.com>
Date:   Wed, 29 Mar 2023 17:16:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] virtio-blk: migrate to the latest patchset version
Content-Language: en-US
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org
References: <20230328022928.1003996-1-dmitry.fomichev@wdc.com>
 <20230328022928.1003996-2-dmitry.fomichev@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230328022928.1003996-2-dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/28/23 11:29, Dmitry Fomichev wrote:
> The merged patch series to support zoned block devices in virtio-blk
> is not the most up to date version. The merged patch can be found at
> 
> https://lore.kernel.org/linux-block/20221016034127.330942-3-dmitry.fomichev@wdc.com/
> 
> , but the latest and reviewed version is
> 
> https://lore.kernel.org/linux-block/20221110053952.3378990-3-dmitry.fomichev@wdc.com/
> 
> The differences between the two are mostly cleanups, but there is one
> change that is very important in terms of compatibility with the
> approved virtio-zbd specification.
> 
> Before it was approved, the OASIS virtio spec had a change in
> VIRTIO_BLK_T_ZONE_APPEND request layout that is not reflected in the
> current virtio-blk driver code. In the running code, the status is
> the first byte of the in-header that is followed by some pad bytes
> and the u64 that carries the sector at which the data has been written
> to the zone back to the driver, aka the append sector.
> 
> This layout turned out to be problematic for implementing in QEMU and
> the request status byte has been eventually made the last byte of the
> in-header. The current code doesn't expect that and this causes the
> append sector value always come as zero to the block layer. This needs
> to be fixed ASAP.
> 
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

A couple of nits below, but otherwise looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

[...]

> @@ -242,11 +240,15 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  				      struct request *req,
>  				      struct virtblk_req *vbr)
>  {
> -	size_t in_hdr_len = sizeof(vbr->status);
> +	size_t in_hdr_len = sizeof(vbr->in_hdr.status);
>  	bool unmap = false;
>  	u32 type;
>  	u64 sector = 0;
>  
> +	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +		op_is_zone_mgmt(req_op(req)))

Weird indentation here. Make this a single line, or align op_is_zone_mgmt() call
to "!".

> +		return BLK_STS_NOTSUPP;
> +
>  	/* Set fields for all request types */
>  	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
>  

[...]

> @@ -794,6 +871,7 @@ static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
>  {
>  	return virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED);
>  }
> +
>  #else
>  
>  /*
> @@ -809,7 +887,6 @@ static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
>  {
>  	return -EOPNOTSUPP;
>  }
> -

Keeping the whiteline between the function definitions would be nicer.

>  static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
>  {
>  	return false;


-- 
Damien Le Moal
Western Digital Research

