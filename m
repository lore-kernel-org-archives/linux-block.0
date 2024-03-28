Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886CC134723
	for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650575; cv=none; b=uz7GKV+98J/aTxsmkUd2PQtfcyGakkx3gGTlBaO0fK3kxy2FGsekDzPa2VvySoS6OiOuswqGdSTOu7kkRq6e3jYzUhbjsHoYDO1pTCJmiEZnEOLnZ36ZygFPKuTHpGbJ6n3afkFG51gVD2d7DHLFa2//Jcj2eErEBXSdinh3aBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650575; c=relaxed/simple;
	bh=GthFzf4c2CnxlFa+euL1T99nUeV+RK/jqmB1OAtv88w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXSQip//rUtTca2lV0pV/FelQZOAA/0Z5lY0qzrdvgew1Qt+sfsbAJsxb723Fp5Le2r7uZ5JpqjnuNv+7vDVFOFju35O+W2O4vxskI5DUhVPpThhcYqOmQdCs/cL5O0NpC190sE1FKm+ovczQNWXOGyYdEdIerlUfzEyajPd2x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ILoBhstR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILoBhstR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711650572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=295Tz66lZ5wzxYSBeQjEsXjOn4yj5P6f+q+3yKW440Y=;
	b=ILoBhstRM6vNqcKFDutUZNvaivwNikLrU0nUZvuHSvNvJUmg6ezOOVFP8Zc4RR3HXbl66p
	pywiJnG6buUzwhkY+ekzZC14kJ/dIzXufXGIEa2AzpkWX+Op1nuYl391yfv1GkIc2ffovm
	WaoC/MgDTViBpeqnMlAcKG5jKm/07mQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-WdrB2UQ4NuKr421MkjDqEQ-1; Thu, 28 Mar 2024 14:29:29 -0400
X-MC-Unique: WdrB2UQ4NuKr421MkjDqEQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6986f2dba1eso10777866d6.2
        for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 11:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711650569; x=1712255369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=295Tz66lZ5wzxYSBeQjEsXjOn4yj5P6f+q+3yKW440Y=;
        b=txoV/0JRmcWf9PWSfXygctepKBI3oFsW+jnUEfaIjdsrd3hTRsPZzwfA/LGPYU23wU
         GA90hGGjupdnq2peCZDc293UlzFMyFxGCVilim0vS6Y8I2pt1dcgIeUDwmiCnW31aHbM
         dhlc6Bye2cnQBA2/tiHffYQkgx4WfeEFTODo12km2dGl7umMbD1DbXAnF6zn3qAkPX/9
         3V3hmbTFbf1XHTbUunZAfs6TwfREbhykoKFX6QbTFRL/SAGt/2XIK8mnDfTmoBMgtXqH
         nqJuR4VaRfdqL+GUsjLOIgCX8zGnWAqcdLW7Z73BP/e7yQ0BjfcLCDykJrtQwcscTLlu
         r92g==
X-Forwarded-Encrypted: i=1; AJvYcCUDOx34jqVyMnePjEFX6M0x4v5zjsb/+NPHmn3SaDwOZXIrDjy+01Y5Rqp745/dQSkTbhRHmY/I983uKCOSg9nolZnx3ds7D77a3j0=
X-Gm-Message-State: AOJu0YztMvh9taLweqo0/FtbUy+klKKAet4jPpNNgK33qGGw3YkHzO64
	vrZYZYlCBVjSHrUnnRrbIeebDiu6YqOz5QOSI6Fcw0TmYLOBwVSe95ku24cIJfkEg+tDB6bZjUW
	HTohu12o/Gc/KxlfLE1BORzdxiTds3UcPsRP8B933HzJ174gM5FTDauKmxqwS
X-Received: by 2002:a0c:d64d:0:b0:696:3a75:2964 with SMTP id e13-20020a0cd64d000000b006963a752964mr57859qvj.18.1711650569466;
        Thu, 28 Mar 2024 11:29:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe5oHWCZzfUomrQkq5TZ0+KX+12VkRPiBcXfHIdH4JazXT/nPJvHY3WgEr/AA6t75OSJCiAw==
X-Received: by 2002:a0c:d64d:0:b0:696:3a75:2964 with SMTP id e13-20020a0cd64d000000b006963a752964mr57839qvj.18.1711650569212;
        Thu, 28 Mar 2024 11:29:29 -0700 (PDT)
Received: from [192.168.1.165] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id c13-20020a056214224d00b006913aa64629sm854751qvc.22.2024.03.28.11.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 11:29:28 -0700 (PDT)
Message-ID: <2ae69d9f-a42c-00d7-f9eb-e93c071153ce@redhat.com>
Date: Thu, 28 Mar 2024 14:29:27 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] block: add a bio_list_merge_init helper
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 dm-devel@lists.linux.dev, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20240328084147.2954434-1-hch@lst.de>
 <20240328084147.2954434-2-hch@lst.de>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20240328084147.2954434-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/28/24 04:41, Christoph Hellwig wrote:
> This is a simple combination of bio_list_merge + bio_list_init
> similar to list_splice_init.  While it only saves a single
> line in a callers, it makes the move all bios from one list to
> another and reinitialize the original pattern a lot more obvious
> in the callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/bio.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 875d792bffff82..9b8a369f44bc6b 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -615,6 +615,13 @@ static inline void bio_list_merge(struct bio_list *bl, struct bio_list *bl2)
>   	bl->tail = bl2->tail;
>   }
>   
> +static inline void bio_list_merge_init(struct bio_list *bl,
> +		struct bio_list *bl2)

Nit: The indentation in this line looks off to me.
Otherwise, for the series:

Reviewed-by: Matthew Sakai <msakai@redhat.com>

> +{
> +	bio_list_merge(bl, bl2);
> +	bio_list_init(bl2);
> +}
> +
>   static inline void bio_list_merge_head(struct bio_list *bl,
>   				       struct bio_list *bl2)
>   {

