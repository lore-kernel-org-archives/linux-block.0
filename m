Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn [61.135.153.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BD91F94A
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 01:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753233403; cv=none; b=sV8Wf1M63ul2yTK5HINgzNCszdMIzG6Wz5I+dxmRJ13lKHHg95OoyfetVeDkUsoFj6h9eI7akkaflotU5u635MYHxa9eAQwO7qlOhcm3NKL9EcKTd+X8eJMOTsfKFztEk9cBB7EwzXZhAQZRI05xHNl0j3WRWm8uIAadqiBd/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753233403; c=relaxed/simple;
	bh=HpWAxKz6dfEx2qW8PsoDIuxoAlc/svq1hqnRyFq7Tqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lY6Sm9HgQCLpfIP4BMq2tah38Q+AcSGJNamvqa1u9X8i8ja2QWAjNmDMBRo0SoG4laWqnnh/pDeTiZt4nQ/Z6l1Z/+mxR8sdD1eGurchXl/9RlfsEmi/BpfrWTqhSThiPPAY3P/66ssRNP6sxgGt6D+zEvcQOdhbsWcEPJK+kXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=yjGek5gU; arc=none smtp.client-ip=61.135.153.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="yjGek5gU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753233396;
	bh=UdnmmYRw0AJu5tW+PGAvB+7PLFGNJroJtC9cg2Qz3GQ=;
	h=From:Subject:Date:Message-ID;
	b=yjGek5gUDUiDjMMgHIWNLKPSEuwz3XvuMYMC3qfj4eN8u+spHjYoE3qM1YU1k8R15
	 Kze2/TH7Tv6N66PKZHpKn98HMMnhp+pmu4fO/8N3g8vX7BJdIEnUrbrxMBdtwkT+Aw
	 wnq+bsu8l5i8YkJQ4+h6k0f0/fi2UOVjcTCzNxjY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 688037E800006558; Wed, 23 Jul 2025 09:16:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6659856291967
X-SMAIL-UIID: 56B947E8854B457CB095FF38F41598FD-20250723-091626-1
From: Hillf Danton <hdanton@sina.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	thomas.hellstrom@linux.intel.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	regressions@lists.linux.dev
Subject: Re: 6.15/regression/bisected - lockdep warning: circular locking dependency detected when plugging USB stick after ffa1e7ada456
Date: Wed, 23 Jul 2025 09:16:13 +0800
Message-ID: <20250723011614.2812-1-hdanton@sina.com>
In-Reply-To: <8acbc346-98f8-44fc-9675-0c3a7da87d21@kernel.dk>
References: <20250722005125.2765-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 22 Jul 2025 06:14:18 -0600 Jens Axboe wrote:
> On 7/21/25 6:51 PM, Hillf Danton wrote:
> > Try the diff that serializes elevator_change() with q->elevator_lock if
> > reproducer is available.
> 
> Hillf, these seemingly random and not tested or thought through patches
> flung out in response to reports is not useful. It just wastes peoples
> time and resources.
> 
Interesting, if you are right, so does the guy who created the deadlock, no?
