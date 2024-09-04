Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96A1E200E
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474195; cv=none; b=evMRNaZB+h+XWyKa2qPcMrzQ51APTttZjhx3gXsiALvSSRj6omXjvYqCUFraa6m5n66zbKQM0AAqApB/zXb6lWP/3ldxSqekm8c4tD7ewm2411FBN69RKRygthRCkcQKwbvgnF+RTos9jOb+2DtIsy+lzjuy6cc+kr1lAlGwtiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474195; c=relaxed/simple;
	bh=nT8gV+YhTlPMYUrXDApYnHMLaUbZFDCBJZWNQZMLF2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcCVKm/N70DvNYAShXj/w2zo9u9nsSpkOpmzyOkzCIai3+AmhsEFDx+Ksclsutl4A7QiNafsSn8GZjnr0lwpui8uPvx22Sqcae4DD5RkBD9z7LlfEhTI4LCtvXFibbAU6QG8g/kE/DtO+g13s8BVIjGOUWWqaZIfBmnxw6jpDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=udBjNb6J; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="udBjNb6J"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82a29c11e1cso234845639f.0
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2024 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725474192; x=1726078992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+eo+Fgqgwtzra6yu9mKiR0DxuIG5S93Eke/Vgclr1VE=;
        b=udBjNb6J/wQdc1RzN2pd/YJQmjZQiNwHst8+qSaCpZraSB9W4CiICF/bRPYpmgk81W
         Fr4NcTKb7pOJM81NLl+K/NFv9ToiEhHGqdO/d+jL0nPoaP8gvtyRoBl6x0so1w3OPKBT
         zT0IILeGi7o0lkkD6zL0TWJuapeLGH34r/20pSOGrpbfE9u6MybTWxZLyxk9sPpcq/8D
         P1yYauD6WZCf+lbAWkNIJVyLrrx6AOUHYv9Q/hjNgQWsSiGNGkmLInIYjs3g95WZIbto
         GfvlxtXd/BCZpiesGX+IQ4X2bNsagX3RsTDiqVuRsG+cpYSh/KfdQoD0sXKm02H+yuTN
         Biaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725474192; x=1726078992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+eo+Fgqgwtzra6yu9mKiR0DxuIG5S93Eke/Vgclr1VE=;
        b=kj7CDAqH87hEYGyfV7iG/Fz9lFAyEwoF451RWRyALi7+Pw80IJMVCMp7SA0IhOo7KB
         wWRi//vIGfYKe6xbIaVKetsU7Miq7j6mW7tvgYF/8aGmvb7SgKNH51d9gTo67pdPw+4k
         8ThietDiNWWyax14cVBvhYv9mLb152xtqbPPk2u74WlQw/Vd/WbVl/HEHidWS6Ho9aQO
         7zvpiq3eNddwT+XvSEGKDfotdK45e0QfxypEOjcAtd3tvrDbMnky3c8TLAToalXFW5+t
         hlrEE1RyhRUcvkYkBO2qyDxUYPVlxgmujEYDPG7+SoXoRLa6E3HcBwQRKUsb7XD2l5jR
         9AfQ==
X-Gm-Message-State: AOJu0YysiGH8VgWNwI4vNBE+BdAGfPd/tIJuThqZhap/PZ20ufaTJc9/
	9MOk9W6iRJ0YOx7dTTCNzml6cgFH/viVx7Fkn7Myg/CS9xz6Gipe1MErmIn4UJqfo9A7lSaRtek
	z
X-Google-Smtp-Source: AGHT+IEyAcEo5YTdncOumjCfKIMxea5NNaZ+J/ERcAtTm0nGttCHazeNPSKBrg8Cnyri+dsX1kZoiw==
X-Received: by 2002:a05:6e02:b2d:b0:3a0:4313:f504 with SMTP id e9e14a558f8ab-3a04313f65bmr21935345ab.2.1725474191777;
        Wed, 04 Sep 2024 11:23:11 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2e92742sm3298792173.100.2024.09.04.11.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 11:23:11 -0700 (PDT)
Message-ID: <c866e433-86cc-4dce-b3b1-7eb42e260ff7@kernel.dk>
Date: Wed, 4 Sep 2024 12:23:10 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] mtip32xx: Remove redundant null pointer checks in
 mtip_hw_debugfs_init()
To: Li Zetao <lizetao1@huawei.com>, hare@suse.de, dlemoal@kernel.org,
 john.g.garry@oracle.com, martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org
References: <20240903144354.2005690-1-lizetao1@huawei.com>
 <3abb351b-64b5-4a11-a2c6-5dbb43ee98b9@kernel.dk>
 <7dc27d37-552e-4b55-b69b-43a93c7d9f57@huawei.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7dc27d37-552e-4b55-b69b-43a93c7d9f57@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 7:18 PM, Li Zetao wrote:
> Hi,
> 
> ? 2024/9/3 22:47, Jens Axboe ??:
>> On 9/3/24 8:43 AM, Li Zetao wrote:
>>> Since the debugfs_create_dir() never returns a null pointer, checking
>>> the return value for a null pointer is redundant, and using IS_ERR is
>>> safe enough.
>>
>> Sigh, why are we seeing so many odd variants of this recently. If you'd
>> do a bit of searching upfront, you'd find that these should not be
>> checked at all rather than changing it from err+null to just an error
>> pointer check.
>>
>> So no to this one, please do at least a tiny bit of research first
>> before blindly making a change based on what some static analyzer told
>> you.
>>
> I have researched in the community before making the modification.
> debugfs_create_file can handle illegal dentry, but my understanding is
> that verifying debugfs_create_dir when it fails can avoid invalid
> calls to debugfs_create_file.
> 
> Greg suggested that I remove this check, maybe I can modify it in v2?

debugfs should tolerate error pointers, hence all the error checking
should just go away rather than being modified. Something ala the below,
totally untested.


diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c6ef0546ffc9..11901f2812ad 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2269,25 +2269,12 @@ static const struct file_operations mtip_flags_fops = {
 	.llseek = no_llseek,
 };
 
-static int mtip_hw_debugfs_init(struct driver_data *dd)
+static void mtip_hw_debugfs_init(struct driver_data *dd)
 {
-	if (!dfs_parent)
-		return -1;
-
 	dd->dfs_node = debugfs_create_dir(dd->disk->disk_name, dfs_parent);
-	if (IS_ERR_OR_NULL(dd->dfs_node)) {
-		dev_warn(&dd->pdev->dev,
-			"Error creating node %s under debugfs\n",
-						dd->disk->disk_name);
-		dd->dfs_node = NULL;
-		return -1;
-	}
-
 	debugfs_create_file("flags", 0444, dd->dfs_node, dd, &mtip_flags_fops);
 	debugfs_create_file("registers", 0444, dd->dfs_node, dd,
 			    &mtip_regs_fops);
-
-	return 0;
 }
 
 static void mtip_hw_debugfs_exit(struct driver_data *dd)
@@ -4043,10 +4030,6 @@ static int __init mtip_init(void)
 	mtip_major = error;
 
 	dfs_parent = debugfs_create_dir("rssd", NULL);
-	if (IS_ERR_OR_NULL(dfs_parent)) {
-		pr_warn("Error creating debugfs parent\n");
-		dfs_parent = NULL;
-	}
 
 	/* Register our PCI operations. */
 	error = pci_register_driver(&mtip_pci_driver);


-- 
Jens Axboe

