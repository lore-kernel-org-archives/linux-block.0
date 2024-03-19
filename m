Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1DC846D
	for <linux-block@vger.kernel.org>; Tue, 19 Mar 2024 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710810852; cv=none; b=sKgn5GPyyecmySkG1mTUiuvamFZYo79yMkKar4FVuGusXQqTn1ts8MWGBHZFBpNrNM5p6JwIn1jF/Z5Rrjw59ZmS2UqICD2H7HHnuHnsNmnYFZn7Pp438o6Xe0p7vamZdQID8D1rprw0eHG6bJLVaphiOQfDmNi7YhR4XyfQq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710810852; c=relaxed/simple;
	bh=aKNtM1auXFf5e2SfSjWXHtQS/lxJHV0FCYpjLFlyrP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwCxps6mRxQ+8GYwTIQCKLTVE3E30yZgzYf0SfETWIAISIWMYWZWPFr79igggql2Rl9ay2EGwMeXbalyuj3DipFNS9iaYVWVWLeofCxU4Ard/QpmiAJ1j7VO8MWt4nFOBQ+Avrxb1lBLaIVBILd4MtpgorLigctBsRVrYn6Mlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hkJJL3+3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkJJL3+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710810849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+ki3M8LXsD9YdHWeoMgF7qk7wGMX3DA1a/BYmADzKU=;
	b=hkJJL3+3Lq/d+xonEY7HfQaqBJv8D+eNird8VUFrvvJ7MNjCdPsf0pDjgc01zOG05J2QOH
	wjXQcAFtczXOYizFXMQ8cohD3bQYcNz96txHjg6/Ok7SuXoVWG1d5wgW6qwNP6A6sg8/Nj
	9kIfK1XH8jbq5QqCM2h+laGYmT1HpPI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-CE8TpcnJMSaK3UwxRB1ZbQ-1; Mon, 18 Mar 2024 21:14:06 -0400
X-MC-Unique: CE8TpcnJMSaK3UwxRB1ZbQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78a09c0a053so103250785a.2
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 18:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710810846; x=1711415646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+ki3M8LXsD9YdHWeoMgF7qk7wGMX3DA1a/BYmADzKU=;
        b=V1W90qpscw7NNdcGBP7E1S4RVJ8hg7sZnaWcV0OA8wHbeLBcWQLAZWrQWWVg2W1oV0
         crE2BdCcd9yZpydFI2O2PocsCYtq9dEEV0c+UWHEz2Y6a/2QqvzVOHDgUxTKdpw7DXwx
         Dy80CF5H6al4kWXA9boP0tXcWazCNklAUWXUmOjiXACu1QNcqqMx59gOwgL+btgUc/uu
         FLao0QoWV1tlmuFytkEpZa6UcVDRdbBjoC2exFnVpG1zuAJcIdvCaDcpCoxWiG7PexJb
         WNOiaOrTWwrP1raM6DN0HIXDhVDyRzF+8FF73s1UMasCb7U9zStLaWmAiqf2odkfstEz
         a6qw==
X-Forwarded-Encrypted: i=1; AJvYcCV9oYJHIFggfM99npZbWPa167gbjQzCFzdbVgsHPQzjSVvNKuBVzCecKYyxoczEMzJpBpaV2hQLFQ+Dm8SH6r0BtDkuTBz1a0L9tcc=
X-Gm-Message-State: AOJu0Yw/3UohDnEvPA96h09y4KG3f5d0H9u1a4q9vFt4GxU5IESzQaDV
	9jUK9k7G59HqaKueq3ssVElt7B8jPx/hqNksg1RKpmv3ZtRjrQgRkg1aqf3Yvfcz0uaNSB/KYoh
	YWIkFToVI2fTmaldAaAlywvrrSBKQqAluWPv2U10WzwE7xNzhMF5ZiXLoEiLE
X-Received: by 2002:a37:c40b:0:b0:788:7404:ae2d with SMTP id d11-20020a37c40b000000b007887404ae2dmr14022884qki.25.1710810846168;
        Mon, 18 Mar 2024 18:14:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWmXddF0iwYjeP4bycVdQMfzAK4D9WL3tJ0LdZ64qcKqDIxZFiH5WyRSavWENWDuEFzVytrw==
X-Received: by 2002:a37:c40b:0:b0:788:7404:ae2d with SMTP id d11-20020a37c40b000000b007887404ae2dmr14022873qki.25.1710810845902;
        Mon, 18 Mar 2024 18:14:05 -0700 (PDT)
Received: from [192.168.1.163] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id d14-20020a05620a204e00b00789e70d135dsm3468404qka.127.2024.03.18.18.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 18:14:05 -0700 (PDT)
Message-ID: <a8be4040-280f-4698-0cfe-d84c0c8bdf34@redhat.com>
Date: Mon, 18 Mar 2024 21:14:04 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 02/39] dm vdo: add the MurmurHash3 fast hashing
 algorithm
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, Kenneth Raeburn <raeburn@redhat.com>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org
References: <20231026214136.1067410-1-msakai@redhat.com>
 <20231026214136.1067410-3-msakai@redhat.com>
 <ea57f231-f78e-4a55-bf85-c5d50e17237e@roeck-us.net>
 <CAK1Ur38jAmWo35HTNrDDAaN5Awiie9wRiPDMVrNUg6+ZM8mJ7A@mail.gmail.com>
 <28a88525-6b06-4215-9e78-2b3d8c0d8657@roeck-us.net>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <28a88525-6b06-4215-9e78-2b3d8c0d8657@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/18/24 16:54, Guenter Roeck wrote:
> On 3/18/24 13:37, Kenneth Raeburn wrote:
>> (resend because of accidental HTML lossage)
>>
>> On Thu, Mar 14, 2024 at 7:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>> On sparc64, with gcc 11.4, the above code results in:
>>>
>>> ERROR: modpost: "__bswapdi2" [drivers/md/dm-vdo/dm-vdo.ko] undefined!
>>>
>>> Guenter
>>
>> Thanks for catching that. I don't think our team has any sparc
>> machines readily available for testing.
>> This is an artifact of our having imported user-mode code to use in
>> the kernel. We should probably be using le64_to_cpup and friends, as
>> we do elsewhere, so it doesn't try to pull in libgcc support routines.
>>
> 
> I am kind of getting wary about reporting such issues. Should I drop
> building dm-vdo images for sparc ? Would it be possible to add
> "depends on BROKEN if SPARC" configuration option to indicate that
> the code isn't expected to be buildable on sparc, much less work ?

First off, sorry for the slow response. I was away for the last couple 
of days.

I would encourage you to report issues when you find them. 
Theoretically, VDO should work on sparc. However since we don't have 
that architecture readily available to us, we won't know what to fix 
unless it gets reported.

In this case, we really shouldn't be relying on these libgcc builtins 
anyway. I hope to have a patch in a couple of days that you can try out. 
If it turns out there are more extensive issues with VDO on sparc, I am 
open to disabling the config, but I hope it won't come to that.

Matt

