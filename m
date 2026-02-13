Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CFA26AF4
	for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771003984; cv=none; b=Pn8zKcOZ8puvk1PS57R6GP4PSBX5pk2RHu9evImwQzWWCCD2JcH5agmewaaojV6OisCYeUZ+j+ESZ8LRc70rH6oM2fML068vOIBHnduuDKAAVQz7esTb1Gxl6KVfatyZh4k/vIHoWdlCtmsSRI1hq3iCunvofkXm/h1tNsTsYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771003984; c=relaxed/simple;
	bh=CsD1vFUSRD78IHMZIPSpdwR01lMJZ4WmxOpaFDSdwMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLa1gTc7hXzbbgcUZzBotLChpy84M3t9ZwKzhyMnp95ZJGYf1HeT/LaKAliquMk7rIiSdFbfdqx9Lv1c8KaG/51ugzejtuB7bLSofK+vvjc71gQc0hbc3Za4sL/7mVWAXlIgc1ix0TaZliCOgk/l7WriGZLH2XGK8usvJbhwhZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=DrbEHDMc; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="DrbEHDMc"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fCK4m5V74z1XM0kC;
	Fri, 13 Feb 2026 17:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771003975; x=1773595976; bh=CsD1vFUSRD78IHMZIPSpdwR0
	1lMJZ4WmxOpaFDSdwMc=; b=DrbEHDMcfD1J9l618td5828nU36lZCt0izKhRbmS
	HhW2dbWI1j+ZQOX/cq9/5EbEVBPz+7TitBHmXcR1QtQ0s80oOW6UmvdPLTgdeNN0
	oDUVkHk//ceOJToPi+UcMdfDgpO10HvdGf8HUgSzBoiMLJnmlt6izIwMYXwD1gSi
	oc5jz2ks1YNJl/5N+VzBv30YecBJw3y8YtwatfscMIZCa6Rl5hsD6XsD9XaHdKRp
	d89kIaj9k5Rj7u6V64veJOlCgq962oSLrIZxbJq5fQPT4cEiV1FIbWTW7jpfXclz
	VeYIHLDX0aVdEnUxC7X4zzgUvO/gacBgdZY0Rsr4U8q3OA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Pz6C9Y81gg4d; Fri, 13 Feb 2026 17:32:55 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fCK4k4XjGz1XM31H;
	Fri, 13 Feb 2026 17:32:54 +0000 (UTC)
Message-ID: <7aca0686-b255-4ece-b766-ebfc90df7340@acm.org>
Date: Fri, 13 Feb 2026 09:32:53 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] A block level, active-active replication
 solution
To: Haris Iqbal <haris.iqbal@ionos.com>, lsf-pc@lists.linux-foundation.org,
 linux-block@vger.kernel.org
Cc: Jia Li <jia.li@ionos.com>
References: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/3/26 7:09 AM, Haris Iqbal wrote:
> We would like to present the idea and internal workings of the
> solution, and also discuss design and some benchmarking results
> (comparison with RAID1 over RNBD/NVMeOF devices, or DRBD) during
> LSF/MM/BPF. We also want to get feedback, and potentially get more
> people involved in the project.

Please prepare for the question why the choice has been made to
implement this functionality as a new kernel module instead of
integrating this functionality in the DRBD kernel driver.

Thanks,

Bart.
