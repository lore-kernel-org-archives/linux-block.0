Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C09D14B955
	for <linux-block@vger.kernel.org>; Fri,  1 Nov 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730419237; cv=none; b=eJTEKz3WJ5jKgxqHV17BcvNQPrWH/U8mrs7tNwuRAfpkbsm6nvNTWCyrBXHfM3i9pJnJX82r+3jHvHq/MgLvnYRd1xmD2cF2V0zkx+XZ1a2WHGy6NVpQNzluMN3I2xUofJgaYmd+xylw5b1GLrEGfOjEJxKezoD1nU+VbV5IDdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730419237; c=relaxed/simple;
	bh=kCbF1BGKFlr0TH22ZVN9QAMkiO+/ZsFquQTfEEVzmss=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gt3gzSgoalk8NeRtv3BRQyw4RR+nZqJ0jdbtVvQZWVWz1a8DcxATorHqO5gyquYZvCxd6iS9FOEOKNxuZ/t6/llHN3cIxItNeC/y7htPbd6zDObvxeTafgsc41GqJzPTkzwG9p9UxKBpngKQutv0g9gVj/y4NIPRp9/3dkbcZXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3M2gN/Mm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3M2gN/Mm"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cf3e36a76so15825195ad.0
        for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 17:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730419230; x=1731024030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dgz+wo5j9vmVU9qVXQho9fYZe5URfdso2CAlnF0E6eg=;
        b=3M2gN/Mm9BB0WTuXJMiI3SaQp1zLxvH5joUPbiaessBStwl5m5VtbLWZVaX8VvbzaH
         tzmUosSmflWyo9EvHRzTDjfa1uwOrLvypE4ThhMmcR1KQXghUV4frecfjvabzgnhCwLh
         nNIe9I60lKD7+xCoz+f6ntsj4TCGC38VWjeVQR24p763OWEZIxWpGYXNmWKsvh33akQ0
         s9Nuq1eN3cDG4I+nBpdbZMZKT0iCCfTrcwVI/mrHgOnjiNpmT3ma7RJ/xPyq4DtU1mu4
         TvUDKu0DlCaSqcRvyzBJ38fhh80TrWdnYjwm4MP7CRKQ5CTP03CAHbE4Rd5+Auxq9ndy
         P2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730419230; x=1731024030;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgz+wo5j9vmVU9qVXQho9fYZe5URfdso2CAlnF0E6eg=;
        b=Q773rvnAf79sXth1rFFvgDtN1WpBkKd/wv0llRBaFcef99dC4crgkmhmMDyQNfaVMI
         RYnsauDNRq85bAsbNL5REc4Vw5Ui3bituaaOEoTuZRWE1ZZsp/VfSrcoGsysf9c/UGsm
         WGrWKql4PJaRd6Q8ZDTtj+k4NIDKZ6/cwNt8IqYayr7c3umh3W2iJjzgWdbJMRXpHD2i
         zmuQXFjPv/ypewCobAb02BVZnSyEZR+ommk1QB0oT2je7JPq99iPLEa5IojQngxFf8AE
         XMWa9mBG+6xpnLGwJxD3VKyhBs15E2d4pyRS/WJOLUm2d2j4HixeXPFdwX+nuIpMw6Zr
         rX4A==
X-Gm-Message-State: AOJu0YwnYYK1bc0G1kP69HI3/AuN4tD8FXfL3Vo6tWlXNtAqm5/0aXjS
	CpLzWl6q9PvUC2BYh8dvt/kpFfNtMiLIr3stuNZXOLxwGyhEy9UiK/VHd+jApTQ=
X-Google-Smtp-Source: AGHT+IHMcPmiGV8WDWLcWhzZV96GKUO9WN1MIbAPV65R3VB7QoMAqyPlyadCJwvNaREewdaCWBACKA==
X-Received: by 2002:a17:903:32c7:b0:20c:b274:34d0 with SMTP id d9443c01a7336-21103c77454mr54294315ad.46.1730419230073;
        Thu, 31 Oct 2024 17:00:30 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3c3esm13691365ad.245.2024.10.31.17.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 17:00:29 -0700 (PDT)
Message-ID: <7bcfad82-3b8d-4bc6-8c7f-f0fee37e77e7@kernel.dk>
Date: Thu, 31 Oct 2024 18:00:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 4/7] io_uring: support SQE group
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>,
 Akilesh Kailash <akailash@google.com>, Kevin Wolf <kwolf@redhat.com>
References: <20241025122247.3709133-1-ming.lei@redhat.com>
 <20241025122247.3709133-5-ming.lei@redhat.com>
 <5d99696d-bc46-421c-b8df-c64dda483215@kernel.dk>
 <6a1978e5-50e4-4591-aecc-4e7191034a9e@kernel.dk>
Content-Language: en-US
In-Reply-To: <6a1978e5-50e4-4591-aecc-4e7191034a9e@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 3:39 PM, Jens Axboe wrote:
> On 10/31/24 3:24 PM, Jens Axboe wrote:
>> On 10/25/24 6:22 AM, Ming Lei wrote:
>>> SQE group is defined as one chain of SQEs starting with the first SQE that
>>> has IOSQE_SQE_GROUP set, and ending with the first subsequent SQE that
>>> doesn't have it set, and it is similar with chain of linked SQEs.
>>>
>>> Not like linked SQEs, each sqe is issued after the previous one is
>>> completed. All SQEs in one group can be submitted in parallel. To simplify
>>> the implementation from beginning, all members are queued after the leader
>>> is completed, however, this way may be changed and leader and members may
>>> be issued concurrently in future.
>>>
>>> The 1st SQE is group leader, and the other SQEs are group member. The whole
>>> group share single IOSQE_IO_LINK and IOSQE_IO_DRAIN from group leader, and
>>> the two flags can't be set for group members. For the sake of
>>> simplicity, IORING_OP_LINK_TIMEOUT is disallowed for SQE group now.
>>>
>>> When the group is in one link chain, this group isn't submitted until the
>>> previous SQE or group is completed. And the following SQE or group can't
>>> be started if this group isn't completed. Failure from any group member will
>>> fail the group leader, then the link chain can be terminated.
>>>
>>> When IOSQE_IO_DRAIN is set for group leader, all requests in this group and
>>> previous requests submitted are drained. Given IOSQE_IO_DRAIN can be set for
>>> group leader only, we respect IO_DRAIN by always completing group leader as
>>> the last one in the group. Meantime it is natural to post leader's CQE
>>> as the last one from application viewpoint.
>>>
>>> Working together with IOSQE_IO_LINK, SQE group provides flexible way to
>>> support N:M dependency, such as:
>>>
>>> - group A is chained with group B together
>>> - group A has N SQEs
>>> - group B has M SQEs
>>>
>>> then M SQEs in group B depend on N SQEs in group A.
>>>
>>> N:M dependency can support some interesting use cases in efficient way:
>>>
>>> 1) read from multiple files, then write the read data into single file
>>>
>>> 2) read from single file, and write the read data into multiple files
>>>
>>> 3) write same data into multiple files, and read data from multiple files and
>>> compare if correct data is written
>>>
>>> Also IOSQE_SQE_GROUP takes the last bit in sqe->flags, but we still can
>>> extend sqe->flags with io_uring context flag, such as use __pad3 for
>>> non-uring_cmd OPs and part of uring_cmd_flags for uring_cmd OP.
>>
>> Did you run the liburing tests with this? I rebased it on top of the
>> flags2 patch I just sent out, and it fails defer-taskrun and crashes
>> link_drain. Don't know if others fail too. I'll try the original one
>> too, but nothing between those two should make a difference. It passes
>> just fine with just the flags2 patch, so I'm a bit suspicious this patch
>> is the issue.
> 
> False alarm, it was my messup adding the group flag. Works just fine.
> I'm attaching the version I tested, on top of that flags2 patch.
> 
> Since we're on the topic - my original bundle patch used a bundle OP to
> define an sqe grouping, which didn't need to use an sqe flag. Any
> particular reason why you went with a flag for this one?
> 
> I do think it comes out nicer with a flag for certain things, like being
> able to link groups. Maybe that's the primary reason.

Various hickups, please just see the patches here, works now:

https://git.kernel.dk/cgit/linux/log/?h=io_uring-group

-- 
Jens Axboe
