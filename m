Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85225173
	for <linux-block@vger.kernel.org>; Sat, 21 Jun 2025 00:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750464743; cv=none; b=Oy86hQ/gWJ0+ffDyat1pdM7wuB1aA2skMI8QuXyoHD9W6BDoZk0Lt9eYDEyVXwegR/OIhaS4mIUxZEaYcJaESmhcMfCJN0Rcb63mhumVcP8T+Stn9n/a1Eo8hSYs+EzxnbEoOtA8yW2L+9LuPsFVgmV/PEMru4YtlnMK1ikMxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750464743; c=relaxed/simple;
	bh=CqT2SNnxBIj3x4HSqPtguLFPwbeprOG1GveLCwU33W8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VlZMAIbZJFhBRdeZH104nYky+VCb5uEDlQA4u/zKgPSE/wc3LqKRRR8yBYGJIB9uzxuK7doIa8CPxHp2PYx19+8KVlrTnOhsn+vRpml7c0oeOxcxcIJBrmT0AgBe2UqOq4ztn7t/u0eFaRxxDKIZGADwgUtyGf13fB1yxO4RYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6sp7r9V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6sp7r9V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750464740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ud8RjfWGNSaD0QBA8zWhPwNXyDJG8YP7ft/4E/heu0=;
	b=h6sp7r9Vi9K2LK+9gC7Sa49BVnP3fhFe89GsEjvLF7fkI3gm9HdBCMLbvIkggJcfAD0MQs
	NtHTFC8pWza5Ni67StTqu9wVhCxKGOyEL8yJcammDBaccTILHwg8wVM3XcvlkqvUjJxVY6
	5cycIihM6uoEwMDwRJaSYibnydzDclc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-owIqI5EdNRKqrftbwxs99A-1; Fri, 20 Jun 2025 20:12:18 -0400
X-MC-Unique: owIqI5EdNRKqrftbwxs99A-1
X-Mimecast-MFC-AGG-ID: owIqI5EdNRKqrftbwxs99A_1750464738
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c791987cf6so454824185a.0
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 17:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750464738; x=1751069538;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ud8RjfWGNSaD0QBA8zWhPwNXyDJG8YP7ft/4E/heu0=;
        b=wFQmC3NmY24CZH12pXgc1kDtRlUM2/jjEuFkzZAj2kNzOJv9JyjyQgt46XlXeEmY8s
         A7Beug5EJ5B4laY+65kPmc2Mrlg8CYgiIzHTd8cxZFivtY6yE84c5gDgQ34GW4G/AZFi
         kYP4i+eoRcXMmJNrLisBjEAtbey0NLuuFiE1Qqbnikw6CnxzZHR9KJTgXzyPQY4pAAvr
         IV+j7RCZKyuzMnfUlZZyxi54JqOnXY07YHVGxFqlW2jAMrzZCxjBdPOt9uudVUemY/A7
         IXvV/kehX7oS8qS28zNq7cZhr56TXKIJQUZMojMMDtw4VpSjYNNOVr/QQQcyRPDDvRkW
         MaAA==
X-Forwarded-Encrypted: i=1; AJvYcCXd9S/W7nPrccO9ZZ1fUI46RIthDEkEQczA9rRRBSDooZu3B6gFsRNRJ4Am/lbZkprjkRaCdfrHqcX6ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5cKQsJDBBARTfx14rWt60C3sSB6CMmasa6nMaRtDMoTLBR33
	cx/TrhliQH0bBNCpBKncTVo4wV+UZgiNDTR/oI1xCKPFenUl0PDDpZgjaBDrsTV+buUpeeqz5CC
	awWpsdm3ROuBmFnI7rpk6aDEIt7E/ihL2aHr/BquorBaE0t4jelK6AHg+TRNU7SSH
X-Gm-Gg: ASbGncst1ulcLqqzncfxMHaPrr4tfgeGUUZqmXym5V4VDo22tJDDzQJK4mA4Hs4NiOf
	sfY2iAXhlozNoqDZSsPFWsF+EJRsnSWeQLmEQr7zSbdNmQiIwkUGtH4ccwSeoCF9rYlXyVvDvx9
	0vPvx8KkgItSYZGDR0w3IBG/z1j3674hwPP5+YFonCrfvNSW33JwUUqZk0sMqzQ0hAVo/CJLpLI
	WpCJ+dRs8DF2i0ep/i1/OW1zXwrx+6iyFksIqh3O5j7L0r7Nj2ychL7VXUg/z+kRVdi1h6vuHkS
	sNO8B7k92dqdB8cF9zQ5kD7HfOQuFQP9JUBbefsfUSceGXA2nnc47KXYQML5gAtaxgtXdRXBE3x
	t/PkARa9lr+8eChyW
X-Received: by 2002:a05:620a:84c8:b0:7d3:9113:78f6 with SMTP id af79cd13be357-7d3f995622bmr806683685a.49.1750464738257;
        Fri, 20 Jun 2025 17:12:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDiGAV6LwHQJTBlNF+heRdcF87AJlNZ8NkAe9KufaDq2/2Ds6tfLhWfwz/EG8PBgTg3byLjw==
X-Received: by 2002:a05:620a:84c8:b0:7d3:9113:78f6 with SMTP id af79cd13be357-7d3f995622bmr806680885a.49.1750464737904;
        Fri, 20 Jun 2025 17:12:17 -0700 (PDT)
Received: from syn-2600-6c64-4e7f-603b-9b92-b2ac-3267-27e9.biz6.spectrum.com ([2600:6c64:4e7f:603b:9b92:b2ac:3267:27e9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99fbdfasm144854585a.85.2025.06.20.17.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 17:12:17 -0700 (PDT)
Message-ID: <d122346c3aea794087da7d9f166a412349517503.camel@redhat.com>
Subject: Re: [PATCH] scsi: storvsc: set max_segment_size as UINT_MAX
 explicitly
From: Laurence Oberman <loberman@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, 
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org, "K. Y. Srinivasan"
	 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	 <wei.liu@kernel.org>, "Ewan D. Milne" <emilne@redhat.com>
Date: Fri, 20 Jun 2025 20:12:15 -0400
In-Reply-To: <20250617050240.GA2178@lst.de>
References: <20250616160509.52491-1-ming.lei@redhat.com>
	 <20250617050240.GA2178@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-11.el9) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2025-06-17 at 07:02 +0200, Christoph Hellwig wrote:
> Please try this proper fix instead:
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index e021f1106bea..09f5fb5b2fb1 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -473,7 +473,9 @@ struct Scsi_Host *scsi_host_alloc(const struct
> scsi_host_template *sht, int priv
>         else
>                 shost->max_sectors = SCSI_DEFAULT_MAX_SECTORS;
>  
> -       if (sht->max_segment_size)
> +       if (sht->virt_boundary_mask)
> +               shost->virt_boundary_mask = sht->virt_boundary_mask;
> +       else if (sht->max_segment_size)
>                 shost->max_segment_size = sht->max_segment_size;
>         else
>                 shost->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> @@ -492,9 +494,6 @@ struct Scsi_Host *scsi_host_alloc(const struct
> scsi_host_template *sht, int priv
>         else
>                 shost->dma_boundary = 0xffffffff;
>  
> -       if (sht->virt_boundary_mask)
> -               shost->virt_boundary_mask = sht->virt_boundary_mask;
> -
>         device_initialize(&shost->shost_gendev);
>         dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
>         shost->shost_gendev.bus = &scsi_bus_type;
> 

Hello

Not sure what you folks will decide as the final fix but Christoph's
patch prevents the REDO corruption as well.
Ran it long enough to know its clean from corruption with this patch
above

Tested-by: Laurence Oberman <loberman@redhat.com>

Thanks vey mauch as always folks

Regards
Laurence




