Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9AB253B67
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192065; cv=none; b=bj8oqLZGKIZ1B1r5NcoEcFHtDXDOjRhbltpYMikGSZ4zU9HdFd5oZD8awKCJ6X1oGnugdSAmFLS/2khQjQgtalDAMTegOIWLRIcSmoUCiuw03bAUrtwmV8rdDC+37PyeetZyKpCPQBYXZwkEyziR6BBzJOHsi/eu0SNfBRAR4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192065; c=relaxed/simple;
	bh=Vg7SCNGZuv6MSzX7s2TH5C/95lcIkGxtA3uOHTXdXys=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Jya2O5NqKW3sZ6qW3w0L/L5IFmJJhfrA8V/x7HawmkfPAo+h9qhcdM+h/d3QMJYbXXeLBnsmxX4ai/333QG2JnQ/aznIusOui/JfRbTL8cXVVTKD9NRyYnZcWC+kYaQH5sYxTUdjx6UzpyzdokMNfFE+6DQGEyG3pWkGLdqBwpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=clpE7MlX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clpE7MlX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741192061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFJCCrP9iOFyoLc3U4Foi0Xf76AnU3YMKrRioOVaMZc=;
	b=clpE7MlXy0hQ1U/Ubvt0arxlOLIeyjdDTKI69LLI/BUL3TGnRQdAVagePmfrPnqMSjunu8
	LQHD3k4SR3ookT2wBLCa/GmZwEd0akEPofalRr+1ecfi0o4jdFqezpBlFukJFxbVSNrm4H
	33AuY0IrG+Loqd5PSuVQxMgDCXfDcJw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-XxLHtujMM_2a3jcLtEcg4w-1; Wed, 05 Mar 2025 11:27:35 -0500
X-MC-Unique: XxLHtujMM_2a3jcLtEcg4w-1
X-Mimecast-MFC-AGG-ID: XxLHtujMM_2a3jcLtEcg4w_1741192055
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e89808749eso159083056d6.3
        for <linux-block@vger.kernel.org>; Wed, 05 Mar 2025 08:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192055; x=1741796855;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFJCCrP9iOFyoLc3U4Foi0Xf76AnU3YMKrRioOVaMZc=;
        b=unPufrxLuM6Mi0IMOtIjSn7ENzl3lYJa452kqh1nrFqq5PzWoiWkHTqnvPWhyUD8ol
         zdsxTeubw+gRyrIvHuzEZgPVm8FGwdiQgFrtf2C5FwwtaU3/MnsgizBgMK/KLUB7Vj2P
         LtIiQn2XHLGSvWBsBu1vI8md42CpZBB9U9ZH1qzxVqiAZAERttejFYoVndRDP2ENbH6n
         +hZidhGMmaIC/jLjjuM7GtdRmXSu7G4URRwC/foHQBDA+L8N0dZzpejfG26wkAX0Bfow
         c2V6kowc/AsIoX3o1cN8vvGGwYOsc15tbIHowfPhDxwQhlOTOKqrex/JppDexqlKsJrP
         2jfg==
X-Forwarded-Encrypted: i=1; AJvYcCWRncVGoYJER8XhyJqui97GJxcrZoDJzL3ArPCslMhLHaeXcSyGzr9pzhA2OkBXigVwOrATq4EVAighEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gZWSw3JZn5CXMRadqgl1u+buK/aF2iyrC/ALoVm0Ui9cHWjo
	X/ZPvTTiCBkKdHDeUiWCwz3KC8ubYupjtfG6IkH8hZQE+gqcYjaJAnuTJQ6GRWQKqRpDPPjq9Ff
	rENRHGijOB/z6JfRV1Vskc4pm3FDbbca4Lzdn1TyNrJKtnCoRfl7btSzlCG2H
X-Gm-Gg: ASbGnct4WRGtjEGTF1mqeLd4i7BQpC/YPTNIu0OlkffNxJvMq1kM2vLf35oUgaRBhsV
	g5gBarBw9CBHNC0pN3PniWnndQXXGqG/R/d/RNyEWHB3yfpcsCcRSpkcUImI60zEM9MNOCulfiC
	MdBrfE4vcKElS4iDDoHDxx4d9XIbYXCN487ZCKAtTkTuLvU82GLNX1bMtDkUR10kySitjno/+O/
	0j7wfdrUor6mGABuwZHXxi40beLWsD4opV36SFW78NgAPHxlozETY0RBVw7ob4S+EnfnEJQ579S
	Ex0XISLK/kgpnxmXIcwUNxLpxrbdphKB+WIEQ0W/CgKzHEaoExK4ZdDpSII=
X-Received: by 2002:a05:6214:21cc:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6e8e6dd876emr66705526d6.38.1741192054922;
        Wed, 05 Mar 2025 08:27:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdjGMu3Z9P5awn0k+syJ1lGAzEkIPJ7IQ68O6zR7KcCUd+jJ3LYDcgb0Pg4YRM3PptFxn4SQ==
X-Received: by 2002:a05:6214:21cc:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6e8e6dd876emr66705186d6.38.1741192054692;
        Wed, 05 Mar 2025 08:27:34 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f401d4bcsm395776d6.124.2025.03.05.08.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 08:27:34 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9c24f14f-c7a8-490e-9077-0d977d175d89@redhat.com>
Date: Wed, 5 Mar 2025 11:27:33 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] cgroup: Print warning when /proc/cgroups is read on
 v2-only system
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-5-mkoutny@suse.com> <Z8cwZluJooqbO7uZ@slm.duckdns.org>
 <t35nwno7wwwq43psp7cumpqco3zmi5n5y2czh3m4nj72qw2udp@ha3g6qnwkzh7>
Content-Language: en-US
In-Reply-To: <t35nwno7wwwq43psp7cumpqco3zmi5n5y2czh3m4nj72qw2udp@ha3g6qnwkzh7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/5/25 5:17 AM, Michal Koutný wrote:
> On Tue, Mar 04, 2025 at 06:55:02AM -1000, Tejun Heo <tj@kernel.org> wrote:
>> I'm hoping that we could deprecate /proc/cgroups entirely. Maybe we can just
>> warn whenever the file is accessed?
> I added the guard with legacy systems (i.e. make this backportable) in
> mind which start with no cgroupfs mounted at all and until they decide
> to continue either v1 or v2 way, looking at /proc/cgroups is fine.
> It should warn users that look at /proc/cgroups in cases when it bears
> no valid information.

I like the idea of warning users about using /etc/cgroups if no v1 
filesystem is mounted. It makes sense to make it backportable to older 
kernel. We can always add a follow-up patch later to always warn about it.

Acked-by: Waiman Long <longman@redhat.com>

