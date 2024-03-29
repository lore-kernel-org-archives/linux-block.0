Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6FA7CF2C
	for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709893; cv=none; b=Oi2FyEOwYXnwFcWw9oOJ4B/Af9M+9Qjxnl01aH5Qppm7d1KqSCEBLqhVtjKgqE6F99jianSapMB9KiwXOOpcv3TrL3q+gZx8ps4Hk3WCi1Id8scD5Q7WMWqO6CGhR1jbLa12BsGWgyVgh96To5o5TBQZP9WBEvry+5okX74IBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709893; c=relaxed/simple;
	bh=g8OQfrHBwhFx8ET7d7s7wkLQtKO+Fbki+HGAG42ZO84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B04p4NaVgbeVexEU1UN26RJFL9FGr09TYmPP97WvlyQOd74MJD+1OvsEw6d+AOdlyQM0rZNraEtwjNdR6z87JxhzKFa/UdM/ZNXIF0WmYwmc5weU87Ai8PxuetoK+D4URuEZkaqcZ8YZgNjZHjhJRzO2KCsD+WlOoIEIbDfujAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QbLejqej; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbLejqej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711709889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ObmCChwbxI4fnx/oMY/3duoto3dJqKFQjwXK6r0ebbk=;
	b=QbLejqejcTXYnpi6v7P/hoStHyYIo+wo9scz/Tc21eZlzdurPz0hDHn0u7VKd+9Qp0eSEF
	m62Hk0k8EnkFDeazd8L6AH5Qina9/+ibheUyOUNdXuW//tJ7croU+Hbw0j3p2AjtmDyqBg
	ad+MedvinPyTUtcIQ53sR+lJuC914dU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-S8yCbHGjMsm3gn06PzMbhw-1; Fri, 29 Mar 2024 06:58:08 -0400
X-MC-Unique: S8yCbHGjMsm3gn06PzMbhw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-515bbb9a73aso1515217e87.0
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 03:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711709887; x=1712314687;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObmCChwbxI4fnx/oMY/3duoto3dJqKFQjwXK6r0ebbk=;
        b=Oy+7kM29SC7TUCu6TAtB4SqptJTozKZMysjJCGKvXuAXz8Ay9v6SDouuwqTMk4wVQo
         pB4S/OKlfe0+719v8aySKjJep1NmVHE+eC2zZ0lKugu+p0djk+n7XCoJIdIPZeTVT1tr
         zuyV2m0R02rQmc4GZRhoZxtlPp+o8T2tdlfDqi0Vs67CXZ35jZuWcSTzXvjJFHyPVv39
         nCPJQLmdFLXM+GoKbiAzcECIh/4JhEjLMp/z82dNB4C95W86Zn8zK/hDV04+GvvnoQgZ
         d9hxb0hbajcBquL7gkahA2gUfoanCSt4CulslWMq86dPr4+wS1tWINFhOzrouyJjjhLb
         uYUg==
X-Forwarded-Encrypted: i=1; AJvYcCX3oI/DM+gGCTFmDab9RDfbGLoYdiMksPZLarpE52bTl9y/64K456fQ8Pb5iBQZ/5TXwLHxiWIQYkgJf4WXbpEfPmfzw3i1IoEhEb0=
X-Gm-Message-State: AOJu0Yxm3rgjyT4F/lmOLk2uqZNVujOkxNBYdUuZUkoVLKZ4FUjuQeh2
	Y33yV6bB0GA/INQbKExGjghzuKeI6uV68ONPzQ2QDWy8ctwz9rDJBmsvb2Ual0HxGlWtOfoBiiD
	fdteZZc0gFu90X8936Vf9C6WsNnw+xAEuY/y6ekq27Z2ay+2U41IhfBew7Vae
X-Received: by 2002:ac2:4197:0:b0:513:d3c0:f66 with SMTP id z23-20020ac24197000000b00513d3c00f66mr1298015lfh.51.1711709886786;
        Fri, 29 Mar 2024 03:58:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG29WemiigJFVRUgtZdZmONK+lboYNHffuMAIXm6vtZQPUrBU42pJdYIugnsyliFC3CMebqVw==
X-Received: by 2002:ac2:4197:0:b0:513:d3c0:f66 with SMTP id z23-20020ac24197000000b00513d3c00f66mr1297956lfh.51.1711709886231;
        Fri, 29 Mar 2024 03:58:06 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id f4-20020a056402194400b0056c4cdc987esm1879596edz.8.2024.03.29.03.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 03:58:05 -0700 (PDT)
Date: Fri, 29 Mar 2024 11:58:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Kalle Valo <kvalo@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Anton Yakovlev <anton.yakovlev@opensynergy.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	v9fs@lists.linux.dev, kvm@vger.kernel.org, linux-wireless@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 09/22] gpio: virtio: drop owner assignment
Message-ID: <wevexb25pa4cwa73tmmlpqyf527drjyfr56j46ddrglofh2mew@sv5hxdqpiu73>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
 <20240327-module-owner-virtio-v1-9-0feffab77d99@linaro.org>
 <CAMRc=McY6PJj7fmLkNv07ogcYq=8fUb2o6w2uA1=D9cbzyoRoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McY6PJj7fmLkNv07ogcYq=8fUb2o6w2uA1=D9cbzyoRoA@mail.gmail.com>

On Fri, Mar 29, 2024 at 11:27:19AM +0100, Bartosz Golaszewski wrote:
>On Wed, Mar 27, 2024 at 1:45 PM Krzysztof Kozlowski
><krzysztof.kozlowski@linaro.org> wrote:
>>
>> virtio core already sets the .owner, so driver does not need to.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Depends on the first patch.
>> ---
>>  drivers/gpio/gpio-virtio.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
>> index fcc5e8c08973..9fae8e396c58 100644
>> --- a/drivers/gpio/gpio-virtio.c
>> +++ b/drivers/gpio/gpio-virtio.c
>> @@ -653,7 +653,6 @@ static struct virtio_driver virtio_gpio_driver = {
>>         .remove                 = virtio_gpio_remove,
>>         .driver                 = {
>>                 .name           = KBUILD_MODNAME,
>> -               .owner          = THIS_MODULE,
>>         },
>>  };
>>  module_virtio_driver(virtio_gpio_driver);
>>
>> --
>> 2.34.1
>>
>
>Applied, thanks!

Did you also applied the first patch of this series?

Without that I'm not sure it's a good idea to apply this patch as also
Krzysztof mentioned after ---.

Thanks,
Stefano

