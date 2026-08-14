Received: from mail.planestimations.com (mail.planestimations.com [45.92.8.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B281E0DE8
	for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.92.8.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786796074; cv=none; b=EBbYb4ZBQoWrGFGThFonk8eC8XisqSGlxRU+7OkH60b6qW8tAZLhMlH2rjOqZmIphGA4tE6YBDckBHzBpiMszNPRgrohn3ndbmblBS/b9luGXrcOPk1GTDjMyJQIUtacuMuBNCpDx/lBOC4Zq7GRf5c8ypUYRFW7ake0l+60RAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786796074; c=relaxed/simple;
	bh=0QW+HqqrQonX/lUbPRJ4jldfY+d+VR2WdTfV61ktcxY=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=Td7h0ERPV5IITFm/A4R/gZU8kFrpz6z1uhuxhDb/yQd/u15D7L5m9qVw1rVqEHdPKy61Z2j6Ac4ruOU21S8ba/ogRLrzATX9NwCAEHw8Y2rOTq+D6tXhHSOyT/UaXpJaqdGW46xZFaC3anZnq8ZcxaPlxvmdxKncE2bZjQ8pM00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=planestimations.com; spf=pass smtp.mailfrom=planestimations.com; dkim=pass (2048-bit key) header.d=planestimations.com header.i=@planestimations.com header.b=Q8SXchSO; arc=none smtp.client-ip=45.92.8.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=planestimations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=planestimations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=planestimations.com header.i=@planestimations.com header.b="Q8SXchSO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=planestimations.com;
	s=202505; t=1786732685;
	bh=0QW+HqqrQonX/lUbPRJ4jldfY+d+VR2WdTfV61ktcxY=;
	h=From:To:Subject:Date:From;
	b=Q8SXchSON2Hk7NUrYGzrTyZO2Rdig0PsX7lpU4XynGTsBdgQaTAs1PcyZ7XIWjxKy
	 ZHsYCja8slu+YhNQYnBmgJtAVZ+w1pri0nuaZY3V1+LcIS9yN5mmGcMPGSM6D9ZkhG
	 C/WYWAkCraGKbe846WU+8qvIVogNhgXAjstz1SVZlh2USLRIeQpauHfJfDzrwCvt2Q
	 b/O+8Ei09Vd+3xpcFFF48/J8WVem3jiSv7SpcvEn9s/88vfb3uOFr8/xSwQhPL9vgW
	 LU3XlPSQzNV9WOB7dHbiuzMNeeN5vYBgiH0qyQXKzT+oF5rbRKCIxlh5PxXVh8Ubz/
	 pFUt/jhRKfG6A==
Received: from [127.0.0.1] (ec2-100-61-145-155.compute-1.amazonaws.com [100.61.145.155])
	by mail.planestimations.com (Postfix) with ESMTPSA id 46D81502159
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 20:38:05 +0200 (CEST)
Message-ID: <82d21d31-45fc-4211-9f8c-03eadc1534f8@planestimations.com>
From: Jane Wells <jw@planestimations.com>
To: linux-block@vger.kernel.org
Subject: Complete CSI Takeoff Services for Your Next Build
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 18:38:04 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hey,

Plan Estimating delivers comprehensive project cost estimates across =
every CSI division including roofing, MEP, structural work, and finishes.

Our team prepares detailed quantity takeoffs with well-structured trade =
summaries, and we=E2=80=99re happy to share a sample for your evaluation.

Would you be available for a quick conversation this week?

Kind regards,

Jane Wells | Sales Representative
Plan Estimating

Click Here to =
Unsubscribe
