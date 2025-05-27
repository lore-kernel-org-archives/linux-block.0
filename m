Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B71227E1C3
	for <linux-block@vger.kernel.org>; Tue, 27 May 2025 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362498; cv=none; b=JndCn7l3GQDibeF0sIvbUQQL26qysHOKqESM4fqI/u2ba4AOgGsRElLwg/vhxLyTR6mLXMYCiwSuKMCz+ZZT7SLXhgoLFDvkCgkgegyoC2QI27vSb8Ft5KbFoOqXzGAs+Tw7c23TtDDKcjSZ2H9Jyvl7ZEnJIyJhyau0JR21714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362498; c=relaxed/simple;
	bh=wyq0WyV3vk6nDobAzyt4od48AzygYViaqGEK0s7ehGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RP69Lhwj4Wzb3mTkMTdAKQaEIK1iTe3O5QqdxegTRTP81Olk+nMBR7eaCk5vZqn2Th8nTgTm0Deh/cJz2A/lHuxqwa0rhxtp1ZrOMqaAtiS5NKgXcwr4JTkjAYWrAbifQ/wwinLY4O0gAPjixKerX2Cf+ZLWrP3bBnSo/Q8L9Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JC2Vf38N; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JC2Vf38N"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d91db4f0c3so11394985ab.3
        for <linux-block@vger.kernel.org>; Tue, 27 May 2025 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748362496; x=1748967296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XI8IZpf/AsheQ7AtgxHZPoN0gkBdv3BHK5qNjpj2aXI=;
        b=JC2Vf38N6bdKm1UWRVJ83Eb55BPPBEPzNgIBlErHIP4f3iszjw17IJ4QVo8x3H5jXB
         AG5U1eaCq1eZYAT+euvXIWJDqUghtdojIDkx4iQhBT+kWtDjnb52ahjFyudnGe7X96KM
         PQjvzvckBFE+dvIrBA+ZJRV4p4h4CaUU5s3bwGDbBYotQVUEkl9hmaI1TGd13ZE5pyuN
         FgFWq5UX+oshP3THm0DwhIqGt53M2F6vbEWU+NDzUNBBOOMcXzjYmfaUwl7G6eQRs01y
         Uog0MaTgzRyw6YhUFU3t2LcV+013mdxERFQVT8IpMjG6DbxzpCKdW3OX/RTvG66E4ESf
         6JOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748362496; x=1748967296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XI8IZpf/AsheQ7AtgxHZPoN0gkBdv3BHK5qNjpj2aXI=;
        b=chkNKdTOeFpBXE9Mi0MqUDJZmzhZCJjTBECS4TwVzjYrpuaqFBeL513NmHuY1RVrId
         yVLzC7IBr7+iIrZXBZ+n6GPJ6BpqS3VJoCXwNGTg5yRVpb/LmWyWUnPolWhyV4/oXnNV
         rP0kBkGGRmlBGx2u4LB9xetyErUfze+A4UkGyXTSfgNk4ZGWhor5V2WvFk8SpJ06XG6G
         X2pw+YVq6ng1wuLLahWkKYALmBLN0jEttcRoIR3DnCA+InLnqI/KK/vmjMMenRCahbx1
         dmAor1IWsmc7HvL2Zlhv9SfMatMY7we2dE5CEOJDW1jTkPbwoq0PT4XWlgy5NK9tWwg0
         wyfQ==
X-Gm-Message-State: AOJu0YxcVyORcsGSj7dRQqH5QMfW9teyPVUbjqy9JQ+NZ+XKPytblDlH
	phB4S3hvIOOC/Z5j1erBhPRcwp/iMwDODq4i/E4wbcNXrS2P9hc14D3mayNf6BivgTU=
X-Gm-Gg: ASbGncvrjF4sUaTeYag3CaPrf75vLj1EjzAJcF0sxqH+XVX5+bml6C0d0sIMwWyEdIk
	wX2h7D8J+wYE34VV+Hb1EoiSK+GR69xvt5Jhp+zfFlSB88uS4hW4ki5LuaLe6XNDvjISVOuxFxu
	F4EAdlemmxD22vwuqmf3mvV0AtM5bjg2Zab1uqaVfpo5RQJMTbtkdY09i6quxldsAC4vQERRyQd
	wYTlXwxJx4IqNykPafD+tt4N/DVmOIZxHaeFW2PFBU0j5xUh4GN9LUBvZCnN+nJVVXnrn7rx3o1
	CZVOxK+T17oQcVYJX3qcLTLTr/v/zNdkflJoioGnVpfP9TcmYQwPN4rTXg==
X-Google-Smtp-Source: AGHT+IFVAfz7ZoKJjbTfFmrotL9nbNqGmssQppCA//4ZYg3D/a/MWoH2Kb1RJd1htWX2FdgDZJvjmg==
X-Received: by 2002:a05:6e02:1547:b0:3dc:6761:4494 with SMTP id e9e14a558f8ab-3dc9b6e7ba3mr140634335ab.18.1748362496068;
        Tue, 27 May 2025 09:14:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dca0409ce3sm20277265ab.58.2025.05.27.09.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 09:14:55 -0700 (PDT)
Message-ID: <8480dacc-9be5-4a7b-b092-4c8fb1bc049d@kernel.dk>
Date: Tue, 27 May 2025 10:14:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] loop: add file_start_write() and file_end_write()
To: Caleb Sander Mateos <csander@purestorage.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>
References: <20250527153405.837216-1-ming.lei@redhat.com>
 <CADUfDZr92uBe1GhVBnVnxt22XCd=uVd-NLj0Kx-3NYmNriJA3A@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZr92uBe1GhVBnVnxt22XCd=uVd-NLj0Kx-3NYmNriJA3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/25 10:13 AM, Caleb Sander Mateos wrote:
> On Tue, May 27, 2025 at 8:34 AM Ming Lei <ming.lei@redhat.com> wrote:
>>
>> file_start_write() and file_end_write() should be added around ->write_iter().
>>
>> Recently we switch to ->write_iter() from vfs_iter_write(), and the
>> implied fs_start_write() and fs_end_write() are lost.
> 
> Still referring to "fs_start_write()" and "fs_end_write()" here

I fixed it up.

-- 
Jens Axboe

