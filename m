Received: from 189sx02-ptr.21cn.com (unknown [14.152.67.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A6F3F3295
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.152.67.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737573; cv=none; b=FLGZtqE+NKFTZvwMY9eYa7vLjCpHmUrU78MASfE86vecPJ8/Rw7uPJc3ozbrADIKFDe1OHxfnxu8cEF9Q2O4Zsjoc7BPq1uSCBJVA19tlbk5BiZFX54HvflM7dnquztdDG2u4CcemVLja7EZ3Db7GIZv2CqkIGbIq5XTOPVUZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737573; c=relaxed/simple;
	bh=FcGznbQFuv63aUfnljTJ0cpbEDTuDjF+knyYObCjspg=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=cJP1QmDYMzCuvnnP0UgWnMgZ78YRy3tCt61wbxXut0i5O+bex+80DwB6gU5MEd2+2BjvhH7QJKvttzOyqGC1QtQgffJS0BvjhxvQmoeCFUnWFPpyxu03rTKjFRJFAOgPGvmN+INqCKruaenemfbNZe7SHmsyhcG2GUDpSuHBpQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=14.152.67.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:0.602659283
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-182.46.50.210 (unknown [10.158.242.145])
	by 189sx02-ptr.21cn.com (HERMES) with SMTP id 6936F12037B
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 00:21:13 +0800 (CST)
Received: from  ([182.46.50.210])
	by gateway-153622-dep-59c444c446-ctskh with ESMTP id 2484293b2c214d80aa2f2c785e893980 for linux-block@vger.kernel.org;
	Thu, 23 Jul 2026 00:21:14 CST
X-Transaction-ID: 2484293b2c214d80aa2f2c785e893980
X-Real-From: 15853655633@189.cn
X-Receive-IP: 182.46.50.210
X-MEDUSA-Status: 0
Sender: 15853655633@189.cn
Date: Thu, 23 Jul 2026 00:21:13 +0800 (CST)
From: 15853655633@189.cn
To: linux-block@vger.kernel.org
Message-ID: <1442556479.76.1784737273226@[192.168.1.200]>
Subject: linux-blktests AI-assisted promotion collaboration
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

linux-blktests: I saw on GitHub that you maintain the blktests testing fram=
ework, which is specifically aimed at Linux kernel developers and storage e=
ngineers. I am a sales representative at Weifang Leimingyun Network Technol=
ogy Co., Ltd. Our team focuses on AI research and development as well as it=
s practical application.

 Given the unique role of open-source projects in technology dissemination,=
 we hope to provide a free license for a full-modal automated marketing and=
 promotion robot. This set of tools aims to assist high-quality projects li=
ke linux-blktests, through AI support, in reaching potential contributors o=
r enterprise users more efficiently while maintaining technical purity, the=
reby enabling natural growth in the project=E2=80=99s influence.

 If this direction aligns with your current promotion plans, would you be w=
illing to add our resource links in the project=E2=80=99s README in exchang=
e for trial access to the tool? Looking forward to your brief reply.
