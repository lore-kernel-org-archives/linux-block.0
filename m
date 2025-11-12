Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031B92E5B0D
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984622; cv=none; b=OKKmipZyNe5I115Wjz2QrZinHiswhsu8XouLYXKpLeQ4v5iteglU40CKQKczNuiw0VKZOk2/n/fKWYqrdPwtczwfsvVMbgNKpLN9stz4rAZGuiYOPl68oWAi+NJB7L9OON+mqsyJHPP4q1m7U3xjYh3wXm2foHzpwYkAVdMq8dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984622; c=relaxed/simple;
	bh=0OTFUF8dKlxaDdn36rkr2KB5xF/wOSqhfWxtBGzWaxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7CTnlVcl6n19Dew4R8UD3ekBrikpldhUC7ii7QHfUWLLbLvSCScnKre8XbPuUg+Nr4RpJV4jeqJjdRRsRywT0VAlWkbzaYcY9sXmEijxxmfEtx3sgN0BH1JGUyF8Caw2Uf+kSBHSUcqx6yVCL3iO4eA/ga//6BIP85MV+IUOP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YTZQqEPi; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YTZQqEPi"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b99dc8f439cso68697a12.0
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 13:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1762984620; x=1763589420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UtzYm6CaQwwng4XDexAXOIVM2T8jYsSpOQI11uV7cIk=;
        b=YTZQqEPiaS/si8bOxnMCFdjnMaTXToGa+627P0ihXde9THCYTRabrnR046dIV/9vpK
         /xGW+/fpk3Ayxcxslmwu8IskYnDVZNHuoz9XgU1oKhwcgEecoUEg0CDvUWsiwQ9QhrD6
         qLzuJ3lhLMCeBg24li73qvZf9qJVTZEH6YQ5QfO7ag9GmeW0S553HICngVx2EtmTy1Zd
         W1TXGld4qghxcGaaLTfm/yqBFdwe9/CMI34rzzA0dL6ygouoq7/eAotojbh3vs493UHc
         P/Yptk1U+JYikQORa3NX0S9xOGe2j4bmELyr8Eqj4URJvRyHBtGASEtlIQxNcDPAl4zc
         Shgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762984620; x=1763589420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtzYm6CaQwwng4XDexAXOIVM2T8jYsSpOQI11uV7cIk=;
        b=jnyjnSCq51Obs4gSB3/mXZPKqrCvhJ33yoKK3PdkVlLax3xkZ3uQiFkSEce/0aO7+F
         G9v13P2vDwe6dwOdjbxokRQBxGmWqQBf9aNq4htqslzLTrdEwq4efiRGJIvxEkXJ7yWV
         /K+cmD/P93F+0c0blU1oHrM6+qM4fyTh7mWBPdon7UXqn/wY3bqbF2f/43MtcEWDXZSx
         fg9KI879uJKOrpCC0nNd7QpP8FI4PNv3O+4m/hahtjFbJZPDHWGWF9vEalrMnWr2XKAH
         XP8TjBafKTOiSPouUGDHs59xVDQBMns2sBgMRzOV85qowQju+KWrzsQd3dXx0F6Mv7Mb
         NIyA==
X-Forwarded-Encrypted: i=1; AJvYcCUbObHg32HjvcTTszrZP9+iA3/7UiiP+7ToRkIlw/HbV9uZHiFP+z3Z6AUzRKE2EKpH6HPmAc7l+OTl+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNr6S0ejtIz1Eb+qQoyI91LjHtK6wPeMshnvU2BK6M+07Kik6d
	ypmJ2HQE7dELyfQLPigMn+RdPTdaJhXQb8lvLbzVeG8ZMDubkkRwVneaKTIbXHsbsrE=
X-Gm-Gg: ASbGnctqU3xKce/bbTXAwSXht3XXxTlZv/zGbpV1eDGpzTx6ePQct1Spv4S9yeT3zb/
	clwWCtGV+eSYhziF8laP4d1yegmMb0kp4Socq5IlKB9vs63KPU8lw/tVOO/DnOdAo/vEvKJLDje
	mE/QPvTCFQcsAD5J+ob0eVrhhVi7byjpLDTKr3Os2NcoMS7sVBFfFMhpYAcH1IMl7gIG0rNAe5V
	Al9i4sl3KoJ04FrOejpYsvIWR2f19hN3xKM95qm4Ux6gbYEASmhyhAVZnZmw2XaBO0xd3taqxIj
	FikYHRGYNayW3ktPfRbKEaxwPudzaTI4tb4/joOlChLakrJn7GXLfghWA8Yu1a/0G9K+9IQ0bvY
	uHSJCPDMPIhmlMq3aEE8X6qes2qzSCw35g7TF6q0proPv8SSOrzrye1xd2KpYb0/1LYBmuMgIHi
	ji0JRWBw0mpygE+8yEMf6QqRJ5GalUYM2eO99TnLqXX4TmTTmmO+g=
X-Google-Smtp-Source: AGHT+IGGcSgtma54hv+7RKzmUmjycRVqw/LnJDNDCrdXo50noFmBCjb2IbQqtC0Ft6zra7BT9FpOHw==
X-Received: by 2002:a17:902:d4c3:b0:28e:756c:707e with SMTP id d9443c01a7336-2984eda94d4mr56523225ad.33.1762984620190;
        Wed, 12 Nov 2025 13:57:00 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccd1fsm1507945ad.110.2025.11.12.13.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:56:59 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vJIpk-00000009zCe-0KVQ;
	Thu, 13 Nov 2025 08:56:56 +1100
Date: Thu, 13 Nov 2025 08:56:56 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	ritesh.list@gmail.com, john.g.garry@oracle.com, tytso@mit.edu,
	willy@infradead.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
	martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
Message-ID: <aRUCqA_UpRftbgce@dread.disaster.area>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762945505.git.ojaswin@linux.ibm.com>

On Wed, Nov 12, 2025 at 04:36:03PM +0530, Ojaswin Mujoo wrote:
> This patch adds support to perform single block RWF_ATOMIC writes for
> iomap xfs buffered IO. This builds upon the inital RFC shared by John
> Garry last year [1]. Most of the details are present in the respective 
> commit messages but I'd mention some of the design points below:

What is the use case for this functionality? i.e. what is the
reason for adding all this complexity?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
