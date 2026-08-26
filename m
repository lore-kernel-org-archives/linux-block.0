Received: from mail.planestimations.com (mail.planestimations.com [45.92.8.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C5743BDDA
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.92.8.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825317; cv=none; b=novzIFe/qhTvoiJOREGapnjtTOSQlkmeszhjMhrXrXvYH0DUWIC7jo5eVUiIhB+o8WxjhEpc9AMqi40GTnrhUFmlQ0IDkVYMEFXSD8xAs4hCJyuzWMr7DHdyFLW8s8qMObavsVMQCFOlVbsnViDcCrNpMF1N5yqpPaCN6AxWdnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825317; c=relaxed/simple;
	bh=OQwF5ERmqkq2R58p47IFfTy0uBlYqeMBIUgzzA3AJI4=;
	h=References:In-Reply-To:Message-ID:From:To:Subject:Date:
	 MIME-Version:Content-Type; b=J5eUe8iE+tSQwBsrX87sBmdIKc/Z6AAYJFiVyFthtbctUUpIXDGDz4WEMloPfGGgubd7cTswSpsreGDKSSzBsSQxb0FZ0CVO7ANQrbubvz7TPXWTDuiwSEJO1irBRrLk8V+q/YKmVoaPEa3rN71Qbg2PYWDKVzG8RfzlCmstvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=planestimations.com; spf=pass smtp.mailfrom=planestimations.com; dkim=pass (2048-bit key) header.d=planestimations.com header.i=@planestimations.com header.b=kmAajdHC; arc=none smtp.client-ip=45.92.8.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=planestimations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=planestimations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=planestimations.com header.i=@planestimations.com header.b="kmAajdHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=planestimations.com;
	s=202505; t=1787744530;
	bh=OQwF5ERmqkq2R58p47IFfTy0uBlYqeMBIUgzzA3AJI4=;
	h=References:In-Reply-To:From:To:Subject:Date:From;
	b=kmAajdHC7P+cyw0X1moJ+VH9xBUd5vDhVCFFUa62HxZUBNnj2maest2YM2l0ljrUF
	 BVRps0sDxVcsb8EMY0wQWLmqqZXtzHWTKhJ+UZ5MTjahgt2S+UQOMCneUQ+CmwTy43
	 8Pd69hx8uHFGPLOq1rWd7mVFdIusoMsPtekCwrnO1b+OQYvDQpBZjYTve9VVHseqKd
	 1vFSo2iLnwwvNlrX36hRQUUXy+WyMF4SMSeVoeNBEobbq300xguWiNGAdYCcoVf7nZ
	 CmutJqjdjvdUYjYhSOrJptISogGTnqbwL+fjjtVgXWTupFgbqpAR6vglrVmXEzlwnv
	 B1o8POtBz2qzA==
Received: from [127.0.0.1] (ec2-32-199-162-166.compute-1.amazonaws.com [32.199.162.166])
	by mail.planestimations.com (Postfix) with ESMTPSA id BB88D504420
	for <linux-block@vger.kernel.org>; Wed, 26 Aug 2026 13:42:09 +0200 (CEST)
References: <82d21d31-45fc-4211-9f8c-03eadc1534f8@planestimations.com>
 <ab3df2c1-6bd3-4732-8567-7e3868728b1e@planestimations.com>
 <7cdc495c-9e8c-4768-9cc2-9918ba96fcc6@planestimations.com>
In-Reply-To: <82d21d31-45fc-4211-9f8c-03eadc1534f8@planestimations.com>
Message-ID: <95348a12-210a-47e4-813f-5b30bde6ea86@planestimations.com>
From: Jane Wells <jw@planestimations.com>
To: linux-block@vger.kernel.org
Subject: Complete CSI Takeoff Services for Your Next Build
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 11:42:08 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hey there,

Just a quick note=E2=80=94we currently have limited slots for =
cost estimating work this week.

If you=E2=80=99re planning upcoming bids, =
we can help with full trade breakdowns.

Just reach out if you'd like to =
get started.

Thanks,

Jane Wells | Sales Representative
Plan Estimating

Click Here to Unsubscribe
