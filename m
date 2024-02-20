Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A705467A18
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429212; cv=none; b=M79iMf9b8hrQ1xEVab1w2OFWXCdsk2SPALNebFCFeb+Lw/sK4giHQwnioae3ZEmBQAXSSBIw7af6LpWtmkBUbie0IU5WDxLawpK0GbJ5sqadLV0KZ1x+k3mt4v0iiXWVTfiYaBQNZ6aYng1XiSGzldgMN7SopBFcJ+VDAFXRc5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429212; c=relaxed/simple;
	bh=Zo35Li8pr8alsUNnTt291AZUdBfzxA3LQFH7VZp2TCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTAtktsKCDUi3S8xn0ZAa6qLIYxuGTjSDK5QteGnP0mQTGEFWQq3LXwItnGWekaNBZNId31VNtxC4hYqJuKPHhCppmy05gV3rcxN5sRhYiNjRrIP7NB9KlFlOQNa7UCBa1kDv0PQwZ99ZH9Zd7DnVjH26arU+xPJMW+KJ2f+JPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=sU9KZnuV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="sU9KZnuV"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512b4388dafso2402502e87.2
        for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 03:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1708429202; x=1709034002; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IGlZzmWp6xz09mlJ1wyOOX/OEeaoUYzGIvASoAaf8N8=;
        b=sU9KZnuVhAw4QcQSYX1ObsHS8kfXWm5mS43NMqQHSgPF219j9XQ1++kzxRw63q1UlB
         BYPiuXGP4ubIaE15sGG/Q/fi3O1tHJXwaUgzKqpvZO6XbRnw6NguRRDbbclSeK8GPx+v
         lqjpmEPHg+BF9Tu1j29NGd9BPhMYndqPSbWpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708429202; x=1709034002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGlZzmWp6xz09mlJ1wyOOX/OEeaoUYzGIvASoAaf8N8=;
        b=jdpQitFexlPYw/C5FQ8WUsEByEqFRliD+MMBS/pekTgx8po3EC7oPbXB0yNlU9UoDd
         ihOA4mAhswiRJS0FK/2XlRr8ZfRxMFlhpMVNI6Mcr/julM93sw32Hf1X4e+F4EhRl23H
         oJZa1OWddq12JOg/JrM4Y2GtmSqym5y44vtmWjGsnyswofFYmZ05/tM8IcfeTSK07jh/
         R79xrvOWZMEfzZpJ6sn5AyW5kQt+I7uwVLLWhH6DHwvpsfhtQ67UlxgkoMowdwnrV5na
         CZ1m1tMRuOGfM5nmCRzCSCrSUFX/rgYGSoyYml3TYZsCvfNYyQtmH5E4QC0JDfMtEwDZ
         IH3g==
X-Forwarded-Encrypted: i=1; AJvYcCXHk52Tmw2+q6SuR9Xpu7lLOx7kCqSnza9Vc5uvy6AYfsbpoeTuADvDGdFNjNt2FMXoI9kiyf4Dp/hmaHSRyPDub2eknrLhufjMoBk=
X-Gm-Message-State: AOJu0Yz5jNJZYMM0OF3onD265fdb/EEBqwGeICIp7NCC8fYSHQwauVN+
	STRstP7rnZvKZJYpKFlPMrthtNvuikvTYN/EJvRgy0HibgfzaZ5ftQutbAxxJt0=
X-Google-Smtp-Source: AGHT+IHbnU1LpWt6trJIlUs3WRM52Tu3ynjqRt6lHOWcYzwBooYpKnWVVL35CFpQMvX5fPKx7bXULg==
X-Received: by 2002:a19:4304:0:b0:512:b3ef:79c6 with SMTP id q4-20020a194304000000b00512b3ef79c6mr3048275lfa.40.1708429201878;
        Tue, 20 Feb 2024 03:40:01 -0800 (PST)
Received: from localhost ([213.195.118.74])
        by smtp.gmail.com with ESMTPSA id jv24-20020a05622aa09800b0042dce775a4bsm3386041qtb.3.2024.02.20.03.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 03:40:01 -0800 (PST)
Date: Tue, 20 Feb 2024 12:39:59 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] xen-blkfront: set max_discard/secure erase limits to
 UINT_MAX
Message-ID: <ZdSPj32Ww80nKQhM@macbook>
References: <20240220084935.3282351-1-hch@lst.de>
 <20240220084935.3282351-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220084935.3282351-2-hch@lst.de>

On Tue, Feb 20, 2024 at 09:49:32AM +0100, Christoph Hellwig wrote:
> Currently xen-blkfront set the max discard limit to the capacity of
> the device, which is suboptimal when the capacity changes.  Just set
> it to UINT_MAX, which has the same effect except and is simpler.

Extra 'except' in the line above?

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
