Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099701;
	b=VkjuLks5gNbMvJG2ylMgd9i5VFWFa3a2pMxfjxRW4V907FY4V5GILujfH5AgrL10F5/k
	 cvM2AYQ83xtyNT2IRNvyEd4fP6LJo2Zw61Enib4ejD7YVuY93m0BAQssaYhKsT7SdAxMe
	 xX/m2oWTdlujPukjYEeV+hS4L6qcX03+K8HFtz1V8MWtU2lmO5N6cH6JgZo51FFZw824T
	 5IsDf3hpQukm8PTNh1etm/qEm+pvuk0smE6XTnvvBpssytlWkTfjplE1kWieN/UXQrhlW
	 RQl0wQl3k/YtiJBDkyOb+yj+ZsVxbdekqEIZJYDK0c7lK5KN7pEGwyHpjGCvw7amLsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099701;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=T3vSSCG3nDSVHiHTKgUz4Oge4REQVEiV7vanpzDz560=;
	b=UAY7KcpLDCUSuVwjucit9KM04vPtHHHF3RaO4cAJrAeFPC86c2JCDIQ4xjejabxAI4jd
	 LQsIc6q9C5OAY9RQ/Kd5jIOHrRhhfNWdtZIbE0ScJRoM6dpIAnikZlW1jCPXhWocxoNFH
	 t1zfOnMwouWyEBoaaphAD9baiMfoaX8n05vYGYLRBQ4vmleemEjFOEETMmOUoLorgRwIS
	 DoZTnOTwL4ygan9sOvfv7SdSVAwUl/FsyOqUZ63Na8CMEr5fH5cQAtHcsi3NPmHygx1PN
	 wZ5ybWk85ZVmd9f3/WZywOPHTdXjGimn0Em+OoT/btqsT8pzTincjUys7Lz40EsXMgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=WX4MedJb;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645F2606E132
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 14:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 645F2606E132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=WX4MedJb
Received: from trampoline.thunk.org (pool-173-48-114-214.bstnma.fios.verizon.net [173.48.114.214])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AJElgqT018265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1795099666; bh=T3vSSCG3nDSVHiHTKgUz4Oge4REQVEiV7vanpzDz560=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=WX4MedJbJdIL78aoFBT9P0brpEumjGLvCHT7A0vM+Y+BCKpFSdHgl0NmiiEmyt5pg
	 qd2kcHfgYht0hKbYZOZAPPJ2iMBxR6z7P3SVl3vQThEothU5fJJdurWhIZOc9GTaH1
	 01D1w7tioqBH9KbkMUvM0VvxqxRhUWB1+EB8L+8JlBIQxuCxpLh4WR7dC//QaR4olP
	 MU2VIU/HIsLdv49uf1w39nOI2hjaST8Z9zIfmZWw1e+el0R+9eDdvwtOGd0+CXP2Cu
	 YkCwOlbNTC2drtusZ+QsVSDcgKcZqKs7hl2KZguyYKUd6SgS4j/rUrx4PByyyh5HfG
	 Dyww/f37blLDw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 73D532E019B; Thu, 19 Nov 2026 09:47:33 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Baokun Li <libaokun@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Zhang Yi <yi.zhang@huawei.com>, Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@linux.dev>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Tal Zussman <tz2294@columbia.edu>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH RFC v2 0/3] ext4: don't complete atomic writes through buffered I/O
Date: Thu, 19 Nov 2026 09:47:24 -0500
Message-ID: <179509948702.1938961.13602175294944718049.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012-ext4-atomic-no-fallback-v2-0-c4b30c60e500@columbia.edu>
References: <20261012-ext4-atomic-no-fallback-v2-0-c4b30c60e500@columbia.edu>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 12 Oct 2026 13:17:39 -0400, Tal Zussman wrote:
> ext4_dio_write_iter() has two ways to finish a write through the page
> cache: the fallback for inodes that can't do direct I/O at all, and the
> completion of a short direct write. Neither provides torn-write
> protection, and neither refuses IOCB_ATOMIC.
> 
> Patch 1 fixes a reachable bug: an atomic write to a data-journaled
> inode is advertised by statx() and then silently done as a buffered
> write. Patch 2 makes a short atomic direct write fail with -EIO instead
> of falling back. That path should be unreachable today, so this is
> defensive. Patch 3 closes the same kind of gap for DAX inodes,
> which ext4_file_write_iter() hands to the DAX path before any atomic
> write handling. No DAX-capable device advertises atomic write limits
> today, so this one is defensive too, and matches XFS.
> 
> [...]

Applied, thanks!

[1/3] ext4: reject atomic writes on inodes that can't do direct I/O
      commit: 44805e53d2cab4cfc58faaae9c70fde0206eecb6
[2/3] ext4: never fall back to buffered I/O for atomic direct writes
      commit: 4562556caa2bedd549038690a4a1481c6446ec41
[3/3] ext4: don't advertise atomic writes for DAX inodes
      commit: 078b328cafee53d4284528a3b07454e0cab955a4

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
