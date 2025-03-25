Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E332326A088
	for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941576; cv=none; b=nhyduD07ElMlKBNqXi9RXED5I7zOGXtgkBKGuXicO6HAT117P5+OYxaSzOYN2I8KJf5S/k9QUStsUQmsbUKL9s+2PRT/R9s1+LF40pBNIFXNbjwZaxsGFl2E374fKommy9rLaNlNufiuT3T1UAAy8q2O0UEWfmdPSDkKC/mGkSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941576; c=relaxed/simple;
	bh=KKtFXFITA4hOuLwA4HcWHFD1w/QWq7sNwvdwYb0AV3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f15JSZlY/sn9GKVU84Y4r7L5CZESeiXAyjELQaSrrr6NSCmOOphjkherYs6ysrpcjhIF0lrDG+bGm/FvMmBgB9cTB/qTi1y19KRkmVb2ckJO4VPK9aglZWL1req98weQCF6E26ZuhtRjcd2fRg5lB03g+wZLfuHlYRxlypmsUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bz9dH6x9; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bz9dH6x9"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-227d6b530d8so51484115ad.3
        for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742941574; x=1743546374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKtFXFITA4hOuLwA4HcWHFD1w/QWq7sNwvdwYb0AV3c=;
        b=bz9dH6x9Mz+fIEKoQQzJKPqpr4dPafCNM4vlLhiEYAoZ/V8uyM1JQO9SBkKlOkFLtZ
         8Wbyqgo/mgcm9xGnBVBBpAeMPoYlKQR7IKLHQthPHb4vxX6UdDrygIqCVq1Vabv/Fyp4
         CujRq0VEDYcKdcl8it5KKfx5oRfYEQmEbQIP44kzSNzYVBlgg0k9wCpH16TVfAu+IU4/
         SKmsoE9OGhGxcgMNvkZRtP2MPlkHwoeZgJFdfwxjJrwR9VcehdG7BnmuLHwGoW0vJFsq
         8SbVu1lQlgz5eH7LpixyYMW3MBfjvFUmC62YLrr7LA113yQGkrPX9U8N1Uf7/grc9Fsm
         dJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941574; x=1743546374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKtFXFITA4hOuLwA4HcWHFD1w/QWq7sNwvdwYb0AV3c=;
        b=uTz6aTyXG7RupVKFj2BEeFTHYb1qU578DD5F6tExAvuIQuovESdTgx/FXjnZKE0sHN
         9tERk9dAkCH/fTA1uit2weIT8qXebAlAzr7+oS4Hog7aNFImA4JWpXdRvMbVaT7kxXEq
         HCeMPdstDOCgJAvnvwQsSUbzivFlV4woRZ+wFaUrZTBhwhfQFKRhaNjMshNJmbFeJXiG
         oAVZZlSOjFT+Fk2oV61u3dEQ5ut87f56OLoV26O4Fkr+UGNRqneks16aZN2swdK+vxfo
         codnc2KXYXZvyIfC0m0d6vHfiKZBpRMuQNqEs6vZb8ebPA/b5DzNHK5giUjR11P4Ebl6
         dg3w==
X-Gm-Message-State: AOJu0YyzN+2BGl53YYK4zqWWQgEA9njt4kPsS0o8taOuLG9kwxNgTmkE
	MWtpO9uWjSqRNQvm0bpZrDNIJdvm+2Mor/WsuSQejI46iMxkCUQhLiIcTONUEHGQfROkL32x+cw
	/Mwa9BPlRKXBE+DGKvFn+1KE1LwTFvU/o0tZ4dKheJ/apR8Qc
X-Gm-Gg: ASbGnctn0uvUha/FCbWrk2U2E9CyBd2QDSeiQ8eV9p69v3thx0b3FQhvqxAX4wwZ+JH
	OdHKzEZKWGVzo3aUvdHU1l7a0tAgYYUs8pBYTCucy7X4bciqy9+lPkh9K4kcLOPwmSeFAkynhg4
	i4YKYP+mkscxbOL5q5LZdtP7VmRbV5TkWNLTtmQeUL5YEl9HOhN4+yYwEAKhIzgdrU+HAHlDp95
	KREYabu1pPa1F/AZ6sNL3/Bz4XhoB2+/gez9PLScTHLbuR5bKVhcL3IGbbo3M41qntTlvni/jH3
	W7wiZUmhMX8vYAAiJQiTgtBoWzLMADr7Lq4=
X-Google-Smtp-Source: AGHT+IGT0KKJcSpjdtMSKMKsUWymjpS7sayjzqsLE4bPkiJaL54O/zO+3IKG+hoGFZrocDh08pKlkUao+W+O
X-Received: by 2002:a17:902:f683:b0:21f:136a:a374 with SMTP id d9443c01a7336-22780e25b3dmr295953605ad.43.1742941574203;
        Tue, 25 Mar 2025 15:26:14 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-227eb1938c4sm643615ad.58.2025.03.25.15.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 15:26:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 70C3234041F;
	Tue, 25 Mar 2025 16:26:13 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 0EFD8E40158; Tue, 25 Mar 2025 16:26:13 -0600 (MDT)
Date: Tue, 25 Mar 2025 16:26:13 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests: ublk: kublk: use ioctl-encoded opcodes
Message-ID: <Z+MthdcV2jaSBnwC@dev-ushankar.dev.purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-1-262f0121a7bd@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325-ublk_timeout-v1-1-262f0121a7bd@purestorage.com>

On Tue, Mar 25, 2025 at 04:19:31PM -0600, Uday Shankar wrote:
> There are a couple of places in the kublk selftests ublk server which
> use the legacy ublk opcodes. These operations fail (with -EOPNOTSUPP) on
> a kernel compiled without CONFIG_BLKDEV_UBLK_LEGACY_OPCODES set. We
> could easily require it to be set as a prerequisite for these selftests,
> but since new applications should not be using the legacy opcodes, use
> the ioctl-encoded opcodes everywhere in kublk.

Is it required to allow for the building of old userspace code (using
legacy opcodes) against new kernel headers? Or do we only need to
guarantee that old userspace code using legacy opcodes that is already
compiled continues to work against newer ublk_drv? If it's the latter
case, maybe we can consider removing the legacy opcode definitions from
the userspace header as a follow-on change?

