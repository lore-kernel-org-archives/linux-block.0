Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C9F262D0B
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771479543; cv=pass; b=GoGdF/nA9PvMzgfVWolILquHJl5oJ8ETPOOWt8BoXVXFO570jeXCbDwNaCLBkk54FLuGzh4HcO+67bD+kr5IYMQ8vvunfTX8V2cJETbzyzbOFoBZ586O9qh1Ns6j25sqNiUcn0PwREOIibELKRo/XFqF+ghCWoNL16QEJehIGHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771479543; c=relaxed/simple;
	bh=JfpGmH93zrf0ivQZq5XswlZvKz2XZ0BAPJqLOFBVyDI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tpv1sMAJIooTPO05/+wgKMM06hciyVfAaZF26OtCmLXfDQMuGwH5ZxzZjJgz9c9RduA5BKfIHvD3+Ik/sHnaRtNEOpLPxRnaQISZGojZBsi1Em3mMO+6M5b86Llkh3OmA74ln8StriFn4DtFHQh1nagGjOPYyFmJrMmRMkT6+FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAqBH+pI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rHvcnijn; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAqBH+pI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rHvcnijn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771479541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=kOS5XCAZ7s18H+yJMwEy2Ks3wIVTG5DOD6ofLB7byYo=;
	b=AAqBH+pI2zugUYF/HxAmXSxnifTE0QI5mMzuKtj3orXDOauwSxgckV89XfynH1Ch77fM6d
	GSrjaHrW/0wNad0MpWra5c/I6U6JFCu2bu7CqAIhQ7FE3TTOiZ0X4xSyF5xeQFwt2na/0O
	ZmTk/4hXBsR+gbPudOMUsd+8fQbyi5E=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-F2X7FZAGP7qPlx7G050eWw-1; Thu, 19 Feb 2026 00:38:59 -0500
X-MC-Unique: F2X7FZAGP7qPlx7G050eWw-1
X-Mimecast-MFC-AGG-ID: F2X7FZAGP7qPlx7G050eWw_1771479538
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-59e5c59df7aso412813e87.1
        for <linux-block@vger.kernel.org>; Wed, 18 Feb 2026 21:38:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771479538; cv=none;
        d=google.com; s=arc-20240605;
        b=c3ckKs1fZyk6mImATQZCG9pjLFl0QJ8fkQjVLIL1ulPxG+mjRYMAcPfbSVoJvaSnlU
         a0KE5ICB8VchbKzZ6cIEC34xrEOZVz0iGxpDj19wqjosDKflp5rT0Abhhwwf5rO5aSxX
         +2tWE+olR9NDzqf5f0q8zgi/bs1Cdq2j54z8QOrBZAdI+oZ2F0Qu8JBHgfRxj+Wq5AaE
         FtoB5PpB06ZtKnIceAczoCxvj7+TdLwAHamGBm7uFi+pTJoDnJ2mVnJkyf7uMOsg3Acc
         OB7cJ3JGsbw1z0QKOPzxqYPiX4J5vfGyfqaHEaEumjEog21UZ2daWCq5VimD7yUXj4A9
         0zgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=kOS5XCAZ7s18H+yJMwEy2Ks3wIVTG5DOD6ofLB7byYo=;
        fh=UYTUZond9cC40q1LNX81k8AyA9OrSzWceiCCaIFaeck=;
        b=c1kIf9bj6BuQUKXgEfrEk27diMPQqogm8TxuF2b7LKtO0AjCLhGWmhuCQK7uskigPx
         GtdWchhDhm+MToOAx7b6SMvNRXUDMqYn34TI74qzknE/V9mOfLjUnFdWXV9cHulegFKJ
         czUk3cgdrHcD/CaLXzjPKmlQaK71pUCB0QhWUcJg/JlG0F/7SjqHgJyL3NeL+9sti/hU
         EyCs0rDMTdCBpOnmxw9XpBMp4DA0ZE/Uhk4BQWY0xOzorMKSMr4WGTkXEodz8YAGUhWf
         8Q8Fv2dUATLLeDczcxf4ERmSOat3rNnmjPzb8v7NPPHdDwUx2Jh0pWo/LBkhFgFGehDm
         gr/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771479538; x=1772084338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kOS5XCAZ7s18H+yJMwEy2Ks3wIVTG5DOD6ofLB7byYo=;
        b=rHvcnijnxE3cTF49pOuZ0aGDtCMxlBbeNOonYZMfxeBvS7h6cxZgSHsGlQZ6oN+E3A
         eGPE2PCC+uan4fjRxhVKr3Yg893XR39BvuTKzXjFa3MZ+ZOyp6uF8ab1RsP+r4lCOMzX
         HP4/v0x8IRN28wa4H2iA1vrWc9LwDaaJ51efiMvM2ESKX2tRSF9+XW7Yq23v/ZTTFhQY
         4XfqZYmHljYTmsdLaJsDjcinZh2ix0fYix9yMhA27niwvZSzGcZsKEPMgvv5hc8bBQHi
         NjHJMdfuxSXW4Y9yY6py21Fc3qJfpp3ZCuTjqx1S2xTgaTG7omwLKVHXNpuHGa1TY+0l
         0xSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771479538; x=1772084338;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOS5XCAZ7s18H+yJMwEy2Ks3wIVTG5DOD6ofLB7byYo=;
        b=qwVGHgz+DYL7zZ57H8a2v3OCQl0a5q9iVrsXQrc2TCikkMiozWijTsQih08q02uzRA
         ZcphEUJmDQHPZGZOeabwltOsZ2oW+lj6hzAF+Ozx3zzxXE0sLStDZLtDAjOVpOFOm6m3
         zVlBd5epKs8l8ljM0OD7E0d/RM6U8GqxXkFJzZJ+4TR0u8WfHAd8+tGVJdxbh3RLezkE
         VrMQ/kQM90on/PSECAbA7e6eV8PbUC+yzOoPwxwlk9Qv4nLGLxvxfGgja0cFwrWqgmYD
         48KYHTnQvrA9LqwNuJwB5d2RcZQlyuEJZeULsUNsVqfaJL60s54C8XL1ysmKc+X5bqte
         ShWw==
X-Forwarded-Encrypted: i=1; AJvYcCV3JyAHMS5S9Ey8sjh9xqyfjirAt5h8L8vJGsSYez5ymuUa6ghcGXZVtmsuOvmC7+dwMVTkbyvQttJ2UA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf4dwJkR9j0VnE+viKc38V8deSaErpjLv75VDUcj+L8wMYZYfA
	jTTZh24nGvgR+K6kvj/nOXJIbLxIeg+fN49sdo2ze9dGjfPSWeRUrSMEO2KHHhTo1KubyaAiSIF
	ozmW+UUffnPw+I3HiZF/lLAmqPK8FGqguaDmLJG8TWbzcWlmn2xcamQjcTDHbFlXYl5FAcClDM4
	bw4hqLSSCxgz8aIN/9KZRAOx2JDAaw/B0qAmRWwEA=
X-Gm-Gg: AZuq6aITzuzvFDHqcDVnCSsYRFysNCbs01WtSGM9e3oIIbuaYC5QCpz/MuzPbBcgzNa
	/tJScA+ImzsY/sXHLEzMNz7ktpL+PaX7xwOkZsDPD429+vG4RBzRvXFCWNjbHQi0ZrkldtGWusx
	rkOPc3sFx+FXIEWzKDejLdwGpxWl/AJTZpCFQW5tivjPvm8dxYaSVX1Yx7kMSZzteiABgmOuX9I
	MLbEBuYy+IlfQM5mDGOCLJGGW9aIVXXAKM84ikq6EQkiZ74e3pom0dgkeSyOq7iJ0PU1WouMBHf
	cBuGIA==
X-Received: by 2002:a05:6512:3190:b0:59d:dffb:cd70 with SMTP id 2adb3069b0e04-59f8adfa16amr216887e87.21.1771479538082;
        Wed, 18 Feb 2026 21:38:58 -0800 (PST)
X-Received: by 2002:a05:6512:3190:b0:59d:dffb:cd70 with SMTP id
 2adb3069b0e04-59f8adfa16amr216874e87.21.1771479537632; Wed, 18 Feb 2026
 21:38:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xiao Ni <xni@redhat.com>
Date: Thu, 19 Feb 2026 13:38:46 +0800
X-Gm-Features: AaiRm511bzlGB3pDN7u3SHsYX-LO7QQII70qqttOYf0DSiJ8VulB68nwomLRZc4
Message-ID: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] User space RAID5 with ublk and io_uring BPF
To: lsf-pc@lists.linux-foundation.org, 
	linux-block <linux-block@vger.kernel.org>, bpf@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi all

I'm doing some work on user-space RAID recently. I'd like to propose a
topic for LSF/MM 2026 regarding the implementation of RAID5 in user
space using ublk and io_uring bpf[1], particularly focusing on the
challenges encountered and potential kernel improvements needed.

Ublk raid5 uses the ublk framework (tools/testing/selftests/ublk/),
with the goal of leveraging io_uring's zero-copy capabilities and
BPF[1] for performance optimization. The implementation includes:
* RAID5 stripe handling with configurable chunk sizes
* Multi-queue support via io_uring
* Degraded mode for single disk failure tolerance
* Integration with io_uring BPF struct_ops framework

During the implementation, I encountered several technical challenges.
The primary challenge is performing XOR parity calculations in a true
zero-copy manner:

1. Bpf program support
Raid5 needs to calculate parity with data. Now io_uring already
supports zero copy. For targets such as raid0/raid1, it's enough. But
for targets such as raid5, it still needs to copy data to userspace
and calculate the parity. Bpf program is a nice solution[1] to resolve
this issue. Besides the patch set[1], it still needs another bpf kfunc
uring_bpf_xor() support.

2. Register buffer per io
Raid5 needs to calculate parity with data. So it still needs to
pre-alloc buffer and register it for each io. The total memory is
controlled by queue number and queue depth. With the pre-alloc memory
and bpf program support, target such as raid5 can support true
zero-copy manner.

Question for discussion:
* Should the kernel provide XOR operation kfuncs for io_uring BPF?
* What would be the appropriate API design?
* Are there security or verification concerns with BPF performing XOR
on registered buffers?

Current Status:
* Basic RAID5 functionality: implemented
* BPF struct_ops framework: successfully integrated
* Performance testing: in progress
* Main blocker: zero-copy XOR implementation waiting for kernel
support I've written a patch for testing based on [1]

Why this matters
User-space block devices (ublk) offer several advantages:
* Faster development and iteration
* Easier debugging
*  Ability to leverage user-space libraries
* No kernel panic risks during development
* Easy to evaluate/compare performance between kernel raid and ublk
based userspace raid.

Desired Outcome
* If proposal in [1] would be acceptable
* Get feedback on whether `uring_bpf_xor()` kfunc would be acceptable
* Discuss API design for BPF-based computation on io_uring buffers
* Understand the roadmap for io_uring + BPF capabilities
* Learn best practices from the community for similar implementations

I'll finish the ublk raid5(tools/testing/selftests/ublk/) and submit
patches later. Also, I'll try to prepare a patch for uring_bpf_xor.
Next, I'll try to impement it based on rublk[2].

[1] https://lore.kernel.org/io-uring/20260106101126.4064990-1-ming.lei@redhat.com/
[2] https://github.com/ublk-org/libublk-rs

Best Regards
Xiao

