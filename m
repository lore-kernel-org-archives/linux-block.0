Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3856113C9C0
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409859; cv=none; b=iNhcjoO/r5d36Xz6WE9QsrkjMI/agHlUi148mkt8yZmrJCHaRyvBiqtqcWKgWNciRF4Q5LOh8au0mH27tROqYRlCgNRQR1ReSbn4lj4GmOFcWOfa95JGGpeO7K7HTPCEzW23wN3zWf+Sx3hhEglCqSEIhZJ/nydZrr6/XNFdNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409859; c=relaxed/simple;
	bh=MhymX7A3Uu+ithNvsEI/GOxTZ8CxLwV6KjVAApSjZNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SF/cDT7UHECn8ZVvhsN2GKxnv2+QmnA6pDj5/QDqUMXnVDhccYhkF4pFYUVlN+9Ct33htBXpeqDL6/7UI7bAgcyoDsEfUCTMyDk5E4e1Zg7GAePANt8ZME4TaiQE1oqhxj2LP4eSdBXg7G2EGMCVJIyeuPmwg8zPM9x7jjk0v3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TXSF1sx/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TXSF1sx/"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so1017535b3a.2
        for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730409852; x=1731014652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O7/HnUXDg/vXS33ST6qzChVVjLK4LIVcVbe/7leAtlw=;
        b=TXSF1sx/1BpeUfqvmD7t00/inVT8As8xGu4GXUjJwH9ZTtfSWbsQqXQ5r+LwiRQBSM
         WPRTJvnyP1YnZQo7xYUMM9wOOc9lz/I2WkLofifsyxADyNYwd25+Cuh6A9b+38jCs9PR
         qH4Z41J/FQRiCon1hKYZ84N/V6fyNN5F+xbc3mC3eNWrz/ypzqOW3fg6NaJ9YzIj63f4
         vNRSwDiVdLfORZTgbzwm94//1EIM9NQnK1RZO/OlFcKyLiWFQa0R412qy57Rx5+f+9QW
         jAxK8PUgvJmueehoHekWC2CAXOhIGsnM2Hdd/PmxxkW6BkGqg7CsaGT4RcTJLuBi809l
         rrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730409852; x=1731014652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7/HnUXDg/vXS33ST6qzChVVjLK4LIVcVbe/7leAtlw=;
        b=Ms/D30L1Kkk7f2FvUgrNqXr+sZoR8Nm8xXxGsep8o+x0yYP43PVyCWRMy6dui7b9zg
         g3ysrMFt8nVOgN1sQtjfKI8obcVcO5n+z9g3o/ujgJc1fEWYeRZgQzeDdEqaU9p2xs+Q
         EosD8L/Ick3eBCwOTHQlFZLwx9kuZw9yD57gz3RggEOOuPZ0AB46i4PDe9G/BUbPJ1ht
         c1V8dqNAGqdwlFKaXgLPXZ5H7a/EmpupODbynglbkLV4nkdATaGplSbxuthh72ZyejPi
         RWqQNPOdqsxzlKmr5GT+HX3m5VhCSpMw3p8vQ7vWW4BOHkDI7koC6EGYItErg37pG3Fq
         Y3zw==
X-Gm-Message-State: AOJu0YykN928lYVeCMWLYAbRbUnhC3LTiOLsMfJppdXgUYBOV7V5CYwg
	2Gk98DvYRyVAvt+IC1DTo2IXIJdiyvbzos/csV6/5LnnfmHt/a2Cjf1mktJAGsc=
X-Google-Smtp-Source: AGHT+IGHH/FzYsWgflbxII3YBb1w6beQMVxD7diTb0MInLD2F/tUVezebR7ZK6ylxwzrc8K+RMDbBg==
X-Received: by 2002:a05:6a00:988:b0:71e:6ef2:6c11 with SMTP id d2e1a72fcca58-72062f874bemr29839614b3a.9.1730409852429;
        Thu, 31 Oct 2024 14:24:12 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8d02sm1580960b3a.43.2024.10.31.14.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 14:24:11 -0700 (PDT)
Message-ID: <5d99696d-bc46-421c-b8df-c64dda483215@kernel.dk>
Date: Thu, 31 Oct 2024 15:24:10 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 4/7] io_uring: support SQE group
To: Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>,
 Akilesh Kailash <akailash@google.com>, Kevin Wolf <kwolf@redhat.com>
References: <20241025122247.3709133-1-ming.lei@redhat.com>
 <20241025122247.3709133-5-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241025122247.3709133-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/24 6:22 AM, Ming Lei wrote:
> SQE group is defined as one chain of SQEs starting with the first SQE that
> has IOSQE_SQE_GROUP set, and ending with the first subsequent SQE that
> doesn't have it set, and it is similar with chain of linked SQEs.
> 
> Not like linked SQEs, each sqe is issued after the previous one is
> completed. All SQEs in one group can be submitted in parallel. To simplify
> the implementation from beginning, all members are queued after the leader
> is completed, however, this way may be changed and leader and members may
> be issued concurrently in future.
> 
> The 1st SQE is group leader, and the other SQEs are group member. The whole
> group share single IOSQE_IO_LINK and IOSQE_IO_DRAIN from group leader, and
> the two flags can't be set for group members. For the sake of
> simplicity, IORING_OP_LINK_TIMEOUT is disallowed for SQE group now.
> 
> When the group is in one link chain, this group isn't submitted until the
> previous SQE or group is completed. And the following SQE or group can't
> be started if this group isn't completed. Failure from any group member will
> fail the group leader, then the link chain can be terminated.
> 
> When IOSQE_IO_DRAIN is set for group leader, all requests in this group and
> previous requests submitted are drained. Given IOSQE_IO_DRAIN can be set for
> group leader only, we respect IO_DRAIN by always completing group leader as
> the last one in the group. Meantime it is natural to post leader's CQE
> as the last one from application viewpoint.
> 
> Working together with IOSQE_IO_LINK, SQE group provides flexible way to
> support N:M dependency, such as:
> 
> - group A is chained with group B together
> - group A has N SQEs
> - group B has M SQEs
> 
> then M SQEs in group B depend on N SQEs in group A.
> 
> N:M dependency can support some interesting use cases in efficient way:
> 
> 1) read from multiple files, then write the read data into single file
> 
> 2) read from single file, and write the read data into multiple files
> 
> 3) write same data into multiple files, and read data from multiple files and
> compare if correct data is written
> 
> Also IOSQE_SQE_GROUP takes the last bit in sqe->flags, but we still can
> extend sqe->flags with io_uring context flag, such as use __pad3 for
> non-uring_cmd OPs and part of uring_cmd_flags for uring_cmd OP.

Did you run the liburing tests with this? I rebased it on top of the
flags2 patch I just sent out, and it fails defer-taskrun and crashes
link_drain. Don't know if others fail too. I'll try the original one
too, but nothing between those two should make a difference. It passes
just fine with just the flags2 patch, so I'm a bit suspicious this patch
is the issue.

-- 
Jens Axboe
