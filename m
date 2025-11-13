Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D66534A3B1
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051983; cv=none; b=RQInXufrI6C7ynLip6lxTWdmvNASSrQYTN2pNGNJjg4aamKvRrriZOCjlVE2vuP90Evivw/ahk5Ne6N+uCqqq+SZHCdbzZzLn6w6jJZp8HA6EncQKYifBrwDsl+AOdTf+E/fetTYGASVomotbtd+bhanP1mZNBVQmSGM0Qx93hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051983; c=relaxed/simple;
	bh=hW177gakDHf+Ufs3x0FyqJ++5WlmyEhFjU4hzGDlJb4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DUVN52v8i88F6tLLCQrAhhsgEsbnrQYw2AD2/VR/g0b/Fn/tWqrrDQukReOrpIh+JEyQN8YIMeFdC2gpeA01X7tg3H+cZ5xmiNsFTsWoZ5dzFj0zZsMpgBBptKqzdcKOehywfRcxWRfks5j6bHc32HDoiBSW23a0z6a5apExvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wN4D4/ma; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wN4D4/ma"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-4336f492d75so6446965ab.1
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 08:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763051980; x=1763656780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwztvobeODOxhK0CvyheBFjMbfSTg5YCa6BHqK/XpGw=;
        b=wN4D4/maZ0eKf0lMC4s1W6VsQ+Mu3CMbsitJbo3LfGzhAtM8eMldmTPkiExdj6P2Mg
         ZtaZ+Ce7aAttBKCAMFXsa90PBrwBEGAaBqp1rJQ9VBRuXtal5I8q9jGbj5Ue/t6eedGe
         3dKZK3sc/MnPh1pq3SYvD4hi2xDPamCCL7gpnROOfURgy6oGqsg2TFANWdsYS7N+srYu
         /3834YsAtvCpSH/YHH0gXV6MFWPl5iWW+VCHBZW7alOtlmyCIb3+2UQSbcBb/i9GM2uf
         impwgrbmTn2t1vbO7neNtizwPNZsCEB0gdE7u/ln9+IX0O5CXcCST53ixM9QT8jyP7M7
         4vJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051980; x=1763656780;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jwztvobeODOxhK0CvyheBFjMbfSTg5YCa6BHqK/XpGw=;
        b=FfyMI6b6oelE00xdd3d7lbHopGryotLtDg1KYpAlTIurDICKloeDdahjQ4bfpBa6qp
         Jh4Rt4LMcrwgn1YzdN5PXjiix3oYHhioGucIynsGqce3vCBoFM4rC4kWt/LV6KlZXup1
         PjzDAsICSAUhPyaC37xSGQQJfTaHemlCnY+Wr/aNVKvCyXQlkM/xgt/dW3kQD5c7sbl0
         6+omr7XwJe/hDPY8HuVJKksUjtjhg1YS84WAK6z9O29tV5Iwz9KzeD6+4wrgkJlHbMGQ
         yTemL9U9a/Zz6WS/T9eGVlExwIrhAVrTKSEr6D9cPg293y4A3Rj6w6NhcFRzhhiR03w2
         qYEg==
X-Gm-Message-State: AOJu0Yz+NKQNP2zr+krwXuj0J/WqBdbhZf44VqG0R3ntacn+40fExOG9
	GlSPqUX1KizeWZwJhB3b8AC6OuHb2aZexz/GYN5Poi0tjHETzPo11WQelfSLsgIZ6NJW5725rML
	4gsZ6
X-Gm-Gg: ASbGncsyXrnNJXbqB8MTwaL6jSTaW/OfBfuvc7YxRpBf4ZP81gLDXccLIEPNK2gOTEj
	mxSvzPALFjVwDQDUylV/r2llL3hWn5strvI+SeL/jCU3xKRL2AolzFLeQjisdLW0pJxyogAN8FM
	VoypMnkeucVlvuI93aMVqwDCCgc6zEa4PiFM+Qm03vLWrPcNZYRVjjf+MZvO/VqMKW/O47i8+pp
	e7hd2ZAWXdrDMNEI3NOD617AUShoE3U9/Gb5zDcezeJ6II7eHNX94q+LvGu0eG2UAvnfCLXp6it
	2j+Gw+sN7QO3l3fIvSCJxXjH8RY2h7Cj85SKlE/JhqFEDwiEeNYkmwtdBOnyTqneh2H22ak2X9a
	S8+uigagykUhSY20qcn/dvyyVJo1OazOKGspydlivkZA09P9xGBcmObbxAJbRgGAW5xs=
X-Google-Smtp-Source: AGHT+IF3aRufDXUXYiyExpWVx2upcPigPhDcwwEm4YNsDP+368K3AwrsMWbwCUWHU/Et4Fmh85T5ZA==
X-Received: by 2002:a05:6e02:1fe2:b0:431:d864:366a with SMTP id e9e14a558f8ab-4348c87b440mr2388545ab.2.1763051979764;
        Thu, 13 Nov 2025 08:39:39 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd35c5f4sm852672173.61.2025.11.13.08.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:39:39 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: ming.lei@redhat.com, hch@lst.de, yi.zhang@redhat.com, czhong@redhat.com, 
 yukuai@fnnas.com, gjoyce@ibm.com
In-Reply-To: <20251113090619.2030737-1-nilay@linux.ibm.com>
References: <20251113090619.2030737-1-nilay@linux.ibm.com>
Subject: Re: [PATCHv7 0/5] block: restructure elevator switch path and fix
 a lockdep splat
Message-Id: <176305197886.133468.154479782311200841.b4-ty@kernel.dk>
Date: Thu, 13 Nov 2025 09:39:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 13 Nov 2025 14:28:17 +0530, Nilay Shroff wrote:
> This patchset reorganizes the elevator switch path used during both
> nr_hw_queues update and elv_iosched_store() operations to address a
> recently reported lockdep splat [1].
> 
> The warning highlights a locking dependency between ->freeze_lock and
> ->elevator_lock on pcpu_alloc_mutex, triggered when the Kyber scheduler
> dynamically allocates its private scheduling data. The fix is to ensure
> that such allocations occur outside the locked sections, thus eliminating
> the dependency chain.
> 
> [...]

Applied, thanks!

[1/5] block: unify elevator tags and type xarrays into struct elv_change_ctx
      commit: 232143b605387b372dee0ec7830f93b93df5f67d
[2/5] block: move elevator tags into struct elevator_resources
      commit: 04728ce90966c54417fd8120a3820104d18ba68d
[3/5] block: introduce alloc_sched_data and free_sched_data elevator methods
      commit: 61019afdf6ac17c8e8f9c42665aa1fa82f04a3e2
[4/5] block: use {alloc|free}_sched data methods
      commit: 0315476e78c050048e80f66334a310e5581b46bb
[5/5] block: define alloc_sched_data and free_sched_data methods for kyber
      commit: d4c3ef56a1618cb7d55a4be74a09cda09165745a

Best regards,
-- 
Jens Axboe



