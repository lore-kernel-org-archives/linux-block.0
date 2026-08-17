Received: from mail.planestimations.com (mail.planestimations.com [45.92.8.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B1B3AA518
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.92.8.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039983; cv=none; b=IEfCQt0c13bRZZdGWaZYwbQjS7gn1BMmyT45ofjv/S1LQytnFW4stcL23iR5TI/i/CiCLurQo/knb9Ov116OY840RI/Lw2IFC3GYpChq0KUVwQ/992VIeIOoz+o4za0HMMhULfjbOLfhrvnVz/4oP9Ey4Vicaq38i6OVzU7K16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039983; c=relaxed/simple;
	bh=jumU5O7U+RHY3BamJ3vSLBDavxx25sPCM4hK9eZOjC4=;
	h=References:In-Reply-To:Message-ID:From:To:Subject:Date:
	 MIME-Version:Content-Type; b=oPhT7dXvfP03QDUoBKRQ0SoER3cCGldBIUBfsLlwfB4hLUq+070YqZjAG1RuxdNWW/KXa+BfW9LQGcANGoDCy0VX+47OWIdG6p8zfGSiTbxjCvr4DKZIBySDeHU6NgP/Y8DRYRIFBPpmaCcK7vDaiHK03YDK9zO8IaBzX/oG+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=planestimations.com; spf=pass smtp.mailfrom=planestimations.com; dkim=pass (2048-bit key) header.d=planestimations.com header.i=@planestimations.com header.b=Y88bbe+P; arc=none smtp.client-ip=45.92.8.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=planestimations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=planestimations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=planestimations.com header.i=@planestimations.com header.b="Y88bbe+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=planestimations.com;
	s=202505; t=1786991953;
	bh=jumU5O7U+RHY3BamJ3vSLBDavxx25sPCM4hK9eZOjC4=;
	h=References:In-Reply-To:From:To:Subject:Date:From;
	b=Y88bbe+PFgKdYG0tc5fK7M95gDWesGKNBr13yNKi25Y4UWPCf8b9Z34V3RGZRZVQ1
	 uThcj+ZzLZSpmL+Kb+ouAZBDW5+r9xRjyxCMRBKb5gCBFNWkVRgowzBwN2+nL6U/YT
	 zWGKWiIBuRsR7o9h+7kbYuYTBSvc0RP4T4pYu4SRMHwqHutS5i4rDmP+rVohKswBKU
	 i/gOEWBbfTf7QQBLRVGev+n2vKTjG1LMHZicqbYVCnMtT7uyqS+J5zv2G7C2DuuG5d
	 qO4jEyHtDJLUupFp4YYLfH9cghIFT8rcy0/JSMyHWtdl+18+LIPnCNrb2nHRtXoq3f
	 48Jns+1BUaQfA==
Received: from [127.0.0.1] (ec2-18-206-218-58.compute-1.amazonaws.com [18.206.218.58])
	by mail.planestimations.com (Postfix) with ESMTPSA id 2FFDB502B92
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 20:39:13 +0200 (CEST)
References: <82d21d31-45fc-4211-9f8c-03eadc1534f8@planestimations.com>
In-Reply-To: <82d21d31-45fc-4211-9f8c-03eadc1534f8@planestimations.com>
Message-ID: <ab3df2c1-6bd3-4732-8567-7e3868728b1e@planestimations.com>
From: Jane Wells <jw@planestimations.com>
To: linux-block@vger.kernel.org
Subject: Complete CSI Takeoff Services for Your Next Build
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 18:39:11 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi there,

Just checking in in case my previous email got buried.

We support builders with fast takeoffs to help improve bid accuracy.

If helpful, I can send a sample estimate so you can see our quality.

Let me know if you=E2=80=99d like to take a look.

Regards,

Jane Wells | Sales Representative
Plan Estimating

Click Here to =
Unsubscribe
