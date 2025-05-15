Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510D420B7FE
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318825; cv=none; b=WGAbwuXhznDO3cyzvBstC8WVbAPA8KoHdyRVvBFzJ3yYzkvrjTC1H6GFYX4iTzgPAsVjEdXY101m1FmNIZNwp2EcQ/mXtXHeZMPXtW12Ih89e2qAOhK96weqjqshtKoILHinj1ovuHKJkF7LtIK4Gjhmk02E3LSSvW2n4ennNcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318825; c=relaxed/simple;
	bh=oTD8c0exwPicDem+wTnqvxJ/wIx8UDXv61avrzM/gV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuOfYlT7QkaQGhkXcEcj1xQwIzxlWLYkbV3hza3XhWJY/iGcENiZk+OmACvgy/JxDz+hg9JN6N1lj/0sBuIDkyKa+/FSb7c8ncLZ2FWtvFbIXEGrF5aByquo4kJ9aIhJSVWLy25RTZD9XKnm9eYt0QGm2piicPy/6aP9tNVzcKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8E4314BF;
	Thu, 15 May 2025 07:20:10 -0700 (PDT)
Received: from usa.arm.com (e123342.arm.com [10.1.196.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 821123F673;
	Thu, 15 May 2025 07:20:21 -0700 (PDT)
From: Aishwarya TCV <aishwarya.tcv@arm.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH for-next] block/blk-throttle: silence !BLK_DEV_IO_TRACE variable warnings
Date: Thu, 15 May 2025 15:20:03 +0100
Message-Id: <20250515142003.1750018-1-aishwarya.tcv@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0687b8cb-d543-4166-9d92-d22fc7188707@kernel.dk>
References: <0687b8cb-d543-4166-9d92-d22fc7188707@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I’ve tested the attached patch on next-20250515 and can confirm that the
kernel builds cleanly without the warning.

Tested-by: Aishwarya TCV <aishwarya.tcv@arm.com>
