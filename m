Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB0E6518E
	for <linux-block@vger.kernel.org>; Tue, 19 Mar 2024 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710814409; cv=none; b=u0vlmSZbR6ZT7bXoSkcwD+XVezEwBV5B7+Se8h4qn3NlORipoRw30Sftkkn5fyQWQpyRlMNmAA3QccbKJbo+TiyKYv72KdPM44eNtKnIvcSlTCS44PYSQyiZidTYBjcyMQeLI132nese78/kK2ZFphBeM4nQoEa0xEGTvKdJTkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710814409; c=relaxed/simple;
	bh=HgXqsL6bokae77+3qonV1fTiuEm5+WKxKPmzpTF7UQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItUqK2YI+EgmUObI6QFEMjz4EO1YCHxPsgtCYV04o5OFuP2qgj/RNIzgqvYNLNOXSO/dYLXWhilZXxPYcllW+SYUm9hQUXRqHstNLtl1jWPteLbG8VtG3pVDwinmpyQB9nuKihrGakQHLXFCsDIxAbE2ZaivxVOBC/AgyO13JjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d0znwoNY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0znwoNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710814407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PR2W7QxFvFoQlpFb6TU+oTBxoI64ohRIcsZtQ1vS4u0=;
	b=d0znwoNYm/b2rBiqdcno8dZ14o2QowKFNZxed18yWclwxumqZ5LhYm4RcYDaiwa175Vxik
	hgkU/2vpfdqLRWHLuCwIPS1j26Ki4ffJp2osVUOPKeJLAwUBHk2cXttQr23O3eGeVvfeJ6
	N/cyyIgy4o374cg4OFInI78h+FR7it0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-47B_Y7VrM7SSxrf910HyvA-1; Mon, 18 Mar 2024 22:13:25 -0400
X-MC-Unique: 47B_Y7VrM7SSxrf910HyvA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78a132dc753so19342385a.1
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 19:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710814405; x=1711419205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PR2W7QxFvFoQlpFb6TU+oTBxoI64ohRIcsZtQ1vS4u0=;
        b=E0gRVJ4M9+9urciNBiroze6gupVCIcPWmtIbRbmVDmOW+eT8BfNeToGLDdZwwJqkGl
         xH1YfAdQaC0QWyRiUKlCZeqS+OenEJCW3B1CNl1KenIfeucyAMJP97pU7kaEqko2wlTi
         vGENmENgG2F1rXcz5HsSdaWETnPmOIGw5q6aHtZGk8KlDdHx5udTRndL8w2VXofnNkzg
         DuYHIU2PbrUMotCQIZU0VtDgmO6e7/aiszF/bBfukVWOgFZ6MBjrGGiVDjm0JES+2Kdm
         QT9OTQ7X8YCxfPcr10UKjTA6n8BD6Fa8tbyMqP7kJRxRrdUB1sPA8mFkyVoz4syE2L8O
         C+mA==
X-Forwarded-Encrypted: i=1; AJvYcCXSEDu4tvSnsxlRHzesh8JDMfmuImJnkI4H93sBJDyFqws8FzsnGD7D6uUfmBRgWWKb2dqbCTfIiR5T9EdUe382fh+snZXXs8BzBvQ=
X-Gm-Message-State: AOJu0YzDY7R7vbwhUo3Tx+G0TFsgQh6TEp0GAM/8MyV20x9jbaj+PBoN
	/eKkChrlNOdMZqxECTOboLA/KrPzj546nJt7rVi8zeryeaL3kBdyPlR1f4sZPcyQHXgcONHD2vx
	yFx9NUMunTtz6aMob/CNF6SQ3ejAclpqDMc9JiwD8uR2LoAar2gzmWcAXf6vv
X-Received: by 2002:a05:620a:ec1:b0:788:2b1c:1e57 with SMTP id x1-20020a05620a0ec100b007882b1c1e57mr14376430qkm.55.1710814405020;
        Mon, 18 Mar 2024 19:13:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6IVS25Egeb7ZU7Mkj2+mrhK7KiNxctSo4ouA/lQ06ajNkcRwpZqlTTzOThSCjm79dmZhgIw==
X-Received: by 2002:a05:620a:ec1:b0:788:2b1c:1e57 with SMTP id x1-20020a05620a0ec100b007882b1c1e57mr14376420qkm.55.1710814404762;
        Mon, 18 Mar 2024 19:13:24 -0700 (PDT)
Received: from [192.168.1.163] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id 20-20020a05620a04d400b007885e3275e9sm5007287qks.132.2024.03.18.19.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 19:13:24 -0700 (PDT)
Message-ID: <0665f6a6-39d9-e730-9403-0348c181dd55@redhat.com>
Date: Mon, 18 Mar 2024 22:13:23 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC v4 linux-next 00/19] fs & block: remove bdev->bd_inode
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, Christian Brauner <brauner@kernel.org>
Cc: jack@suse.cz, hch@lst.de, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>, dm-devel@lists.linux.dev
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <1324ffb5-28b6-34fb-014e-3f57df714095@huawei.com>
 <20240315-assoziieren-hacken-b43f24f78970@brauner>
 <ac0eb132-c604-9761-bce5-69158e73f256@huaweicloud.com>
 <20240318-mythisch-pittoresk-1c57af743061@brauner>
 <c9bfba49-9611-c965-713c-1ef0b1e305ce@huaweicloud.com>
 <dd4e443a-696d-b02f-44ff-4649b585ef17@huaweicloud.com>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <dd4e443a-696d-b02f-44ff-4649b585ef17@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/18/24 21:43, Yu Kuai wrote:
> Hi,
> 
> 在 2024/03/19 9:18, Yu Kuai 写道:
>> Hi,
>>
>> 在 2024/03/18 17:39, Christian Brauner 写道:
>>> On Sat, Mar 16, 2024 at 10:49:33AM +0800, Yu Kuai wrote:
>>>> Hi, Christian
>>>>
>>>> 在 2024/03/15 21:54, Christian Brauner 写道:
>>>>> On Fri, Mar 15, 2024 at 08:08:49PM +0800, Yu Kuai wrote:
>>>>>> Hi, Christian
>>>>>> Hi, Christoph
>>>>>> Hi, Jan
>>>>>>
>>>>>> Perhaps now is a good time to send a formal version of this set.
>>>>>> However, I'm not sure yet what branch should I rebase and send 
>>>>>> this set.
>>>>>> Should I send to the vfs tree?
>>>>>
>>>>> Nearly all of it is in fs/ so I'd say yes.
>>>>> .
>>>>
>>>> I see that you just create a new branch vfs.fixes, perhaps can I rebase
>>>> this set against this branch?
>>>
>>> Please base it on vfs.super. I'll rebase it to v6.9-rc1 on Sunday.
>>
>> Okay, I just see that vfs.super doesn't contain commit
>> 1cdeac6da33f("btrfs: pass btrfs_device to btrfs_scratch_superblocks()"),
>> and you might need to fix the conflict at some point.
> 
> And there is another problem, dm-vdo doesn't exist in vfs.super yet. Do
> you still want me to rebase here?
> 

The dm-vdo changes don't appear to rely on earlier patches in the 
series, so I think dm-vdo could incorporate the dm-vdo patch 
independently from the rest of the series, if that would be helpful. (I 
don't want to confuse things too much.) In that case it would go through 
the dm tree with the rest of dm-vdo.

Matt

