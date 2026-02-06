Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FDF125A0
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391849; cv=none; b=c/ZBE2WNlOWRlPHm7F6PAo/JslfD94buznWLvxF+s500OpFU909UZyc2dcO0UYiqsD074GGA121fOkjZr5A/vR6hIbV7Zaf1HrQ1Dea194TBgVbX45VypRVsqBkLd9jHE3iaL/QLCa+H1083zX4naDUQTDbrguYDEqcipmMNiB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391849; c=relaxed/simple;
	bh=ngk1LzR9/uUd4RJFz0bD6uqseSPL3AONrCCs6ttaPXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBttdlFPtwTgTgNhogeKTv4uizXh7ucwLlDxUdrNp8pF0TL2XpPxNEiTzxPkFVBgagPr+SFIVUmWTPem4FJgro5+spW1dSalUg/TEAIYZkU0D/Y0ZjDrbB0Z8S62qGekxRn0fUKXCxgRRpNqC+BZn9Ass2mhM/9sw9ftr/cAIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbaLw1La; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbaLw1La"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4359a16a400so2210251f8f.1
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 07:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770391848; x=1770996648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FiuzeKES9rDDSINlTwU+2mg+F8PdKmrrdAX7+vK5jPg=;
        b=CbaLw1LaBijHpNvPQw4eYxBBd0a4Zj7ajiS9nZFUj8OfAB5BUnaYsWBnFAI4GbAln0
         xGtACr5WgVPV7LGnOv916f1pFe98mRr0WtOt+ewc9us8gluebZYXfxLof9Gc9wG0ueip
         UNM7nObC2OXoRS1N8DrdEPD+UuJFMiT4NbMDmE0HJoM+B0PZbq8udWzVqWuK2aJUQljd
         pchCE8UmBDWaVY8yeauZxJGqcQZRTqxMVwfFTRigMGrWJkyht5J+2X67+nV0hu2DRUoO
         pKn2YUgtI6rDk/rJ8+nkZvt7GAPfx+cWJv2QbJBH0JrsRYpwo/I6UDZNQwkH0q5UX+Td
         /dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770391848; x=1770996648;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiuzeKES9rDDSINlTwU+2mg+F8PdKmrrdAX7+vK5jPg=;
        b=PzHtxzUzMB4DpskvzLCQodVCNGgX5McH7ZQY+1QVt1yMMWHlOcvNbT/888h2SSW+zl
         09Aeo5LjdA2hlM65/l0mUtMI7MptswqRur180kicqu3qQ5U6Dy9shUsGE+6glSIhaLBN
         48Pdb4KDg8hEIyXUXJqtr6hM0Md3JAkTldnrd8ckMoEIT2rgYHI7J5P951ARMO7L1zJy
         4JKFr34xLNT2DSrXc32PmHAsHAvBPI1MorEihM3FQEe/DF80NaZyiVwBYS1o/JQOLWEx
         Lj/8uPS/qL5mhe+BuXv8EdZ84561DNo63RpCYP7dNpjldAYmanSEQKxK3OYd9zaK4KkX
         Mb6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUi/UiEUUx+okkvzDy7bp8HHUmSNGvt2aZsrSeHGTTcD4V4HLUxp8NBnU+8sXVkb9sUP76Ti7Al8E9qOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSb3CD40mXD/Ux59LYGjfYNpCQXr5V3aaS3GclrUclYicJxFm8
	rjdh10/k03HoqXpTyvxI346r09j3WxNBvZ4dpEmIbhHeBue51PAfuV6V
X-Gm-Gg: AZuq6aIlUHBVmOtKIZp1AI4cZJ63zXTD9AU51WDS6nIryAKe3D7FT6tOO4JAJYGwHLH
	H6h1kOz/J9JnL9pCeLCDLXsdBLdPeNgj00/ms/8K04wwPrNx56TW/lDb2gbFDRtD1OdVebahzjf
	pWPJt/GI5DGm0qBR0S16pk1zIGGmAY+2bGrjYpqAb8OwW5uAGRYMOXNHzYqXaif6C8tpgI9nDMf
	sULdShH6pXJDe0igOlSDd4ZBQrFxC8V0ppAR/6SEAW+NeaYXWhuIZLdxqs9BsRowfzN0dFVfPCh
	wnNusi6+daFZeuc4ngGTp8Ql30r0Y44HGbEBgHv2ge0OfaUWiXYYkew0D5VIKPbhI/XxGylPXgs
	k/xSzCpvST1/gWLD4RxsDS8mJl0Ib9r2h5i00B7TWmGqYdC1oGwf5cW7DB56bw7T4lra7qJQAGb
	LaebX3H/Y1gd5sGcy/+YK+UrCQ5IUdM6D+Kjqo
X-Received: by 2002:a05:6000:2209:b0:430:feb3:f5ae with SMTP id ffacd0b85a97d-4362938fbddmr4652754f8f.55.1770391847539;
        Fri, 06 Feb 2026 07:30:47 -0800 (PST)
Received: from [192.168.2.14] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd4a1sm6782642f8f.17.2026.02.06.07.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 07:30:47 -0800 (PST)
Message-ID: <5f984628-2547-4393-b5ff-23d8e4d5481a@gmail.com>
Date: Fri, 6 Feb 2026 16:30:46 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] sed-opal: add UID of Locking Table.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: jonathan.derrick@linux.dev, gjoyce@ibm.com, hare@suse.de
References: <20260205150935.238137-1-okozina@redhat.com>
 <20260206141804.278721-2-okozina@redhat.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20260206141804.278721-2-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/26 3:17 PM, Ondrej Kozina wrote:
> As described in ch. 6.3, Table 240 in TCG Storage
> Architecture Core Specification document.
> 
> It's also referenced in TCG Storage Opal SSC Feature Set:
> Single User Mode document, ch. 3.1.1.1 Reactivate method.
> 
> It will be used later in Reactivate method implemetation
> for sed-opal interface.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> ---
>   block/opal_proto.h | 1 +
>   block/sed-opal.c   | 2 ++
>   2 files changed, 3 insertions(+)

Reviewed-and-tested-by: Milan Broz <gmazyland@gmail.com>

Thanks,
Milan

