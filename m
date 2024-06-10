Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD81B948;
	Mon, 10 Jun 2024 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047067; cv=none; b=Ujaqk5ZUungj8YezVNi+OkN+4PTDf4KW6FMd/89RMh8YPEvWEqEI2tgVcSNPSesP9mqH/gcds7kT7Nhawi24rYdaOF0bUBuJ3bENdsqFzTE0jfwNS0ni2vwHOZzJ1y1xRfli7BM3eB+LSTKtqtG9ATfj5Gt+nfH++lPne2u7iWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047067; c=relaxed/simple;
	bh=CYOT76AfBouQqbVpCUNSBB4l/OiuTBOVCq0qRX+tvHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdAhhwIpc7FJj6UAFnTT/M1eApg2Tod+RlbSSuVD/PMx9L6aRje2dsTRWLB1i95jPBPn/k2dY1rdYLES3vJ/G5sOPvyK6cT8zJCWv7ursLeOkkJdtocR+4mUaImCLHGnVdgpoOBm5lAQres+zIMSZFW3vwlVdZInE+r0CACI0/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-421de6e748aso618395e9.2;
        Mon, 10 Jun 2024 12:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718047064; x=1718651864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TjxwdtwDBf9dpqHFM5EICaXQ28U0dNmB1rsvDAYAh4=;
        b=C37YeKsRAbU+Zl38CEG7nW+ZTztWBuOA55x6F54LcNKt1dtbSM+zB+ZXOeJVpcW1Th
         WVHUUGhlz+tPEeEx+0JMlMXBJp8IzHfX2F15vKC5ZBdNBhkV3g/BdfCePsV3FGMV9ZXn
         Fi9rYBHsxsgjAP22npMel3mvDvXW2oALJ6SUBuX5Ge1codojPhnitmIFkND9yhlQj5t1
         Wx+QKidwQbzTRXaePuXlqrpgxv+BRVtYaH0vNHelfE9fYA5nzhinq9qIt5gFkchI46xK
         5Cd6tBS1QmwRfSDA32PLdpjAPNsKh7uS5oKOAJim8I/Z8Cqd1t3mzsvPQ5oKQFZ56Ct6
         NT5A==
X-Forwarded-Encrypted: i=1; AJvYcCXtbsb2BI9KhQSI074rtVeXu+sIpSJuDN3yLHznsfDXDQ23a4xUXzklDBjgBVsorqLq7oXAT671LEsZOpNDmBVENXVuW5FKUW1m/rkyxrx0dCAk61UjyKVxSEZnwUCVP7nywZJen/k9n3k=
X-Gm-Message-State: AOJu0YxUFuIzOEbY2kfFVpsOVKD0drHnx2+6TMf35NUVEAZXJ4/IapmK
	TZhbbLQ7N3wIqt16FkGG9W/V5rt439dVS4Pp6eCjrbuhLF1Q+1AseuzTisYl
X-Google-Smtp-Source: AGHT+IG+Arhc0Ki2O2+3o5JkvJ//dutAV8umCJHhjPj9FFAHbXcosO2mEhVAJGDN3XGI/o1YqR+BZw==
X-Received: by 2002:a5d:588e:0:b0:34d:b5d6:fe4b with SMTP id ffacd0b85a97d-35efedd2e3emr7494771f8f.4.1718047064037;
        Mon, 10 Jun 2024 12:17:44 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e567sm152346085e9.1.2024.06.10.12.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 12:17:43 -0700 (PDT)
Message-ID: <bccf1e1f-bc45-4052-9504-d852f9ae4e6c@grimberg.me>
Date: Mon, 10 Jun 2024 22:17:42 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel OOPS while creating a NVMe Namespace
To: Keith Busch <kbusch@kernel.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sachinp@linux.vnet.com
References: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
 <ZmdLlaVO-QUug5aj@kbusch-mbp.dhcp.thefacebook.com>
 <e8fa4c36-49e5-40b8-9cea-6b3b61aa3240@grimberg.me>
 <ZmdQuz8vJZMj41Kn@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZmdQuz8vJZMj41Kn@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/06/2024 22:15, Keith Busch wrote:
> On Mon, Jun 10, 2024 at 10:05:00PM +0300, Sagi Grimberg wrote:
>>
>> On 10/06/2024 21:53, Keith Busch wrote:
>>> On Mon, Jun 10, 2024 at 01:21:00PM +0530, Venkat Rao Bagalkote wrote:
>>>> Issue is introduced by the patch: be647e2c76b27f409cdd520f66c95be888b553a3.
>>> My mistake. The namespace remove list appears to be getting corrupted
>>> because I'm using the wrong APIs to replace a "list_move_tail". This is
>>> fixing the issue on my end:
>>>
>>> ---
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 7c9f91314d366..c667290de5133 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3959,9 +3959,10 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>>>    	mutex_lock(&ctrl->namespaces_lock);
>>>    	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
>>> -		if (ns->head->ns_id > nsid)
>>> -			list_splice_init_rcu(&ns->list, &rm_list,
>>> -					     synchronize_rcu);
>>> +		if (ns->head->ns_id > nsid) {
>>> +			list_del_rcu(&ns->list);
>>> +			list_add_tail_rcu(&ns->list, &rm_list);
>>> +		}
>>>    	}
>>>    	mutex_unlock(&ctrl->namespaces_lock);
>>>    	synchronize_srcu(&ctrl->srcu);
>>> --
>> Can we add a reproducer for this in blktests? I'm assuming that we can
>> easily trigger this
>> with adding/removing nvmet namespaces?
> I'm testing this with Namespace Manamgent commands, which nvmet doesn't
> support. You can recreate the issue by detaching the last namespace.
>

I think the same will happen in a test that creates two namespaces and 
then echo 0 > ns/enable.
