Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324240;
	b=twn1OuZhEOzHwVXF6coF3CGZxuYT9Pgts2L0fCo4L7BhxaOHNw01XEnvYyQFyK06e4KT
	 I8aQ73527LCLJvLJytd49MwPG3rbjlp2pkHz7eKRVtgTPLCNOVxFQvaNVnyPnYfS2OfVk
	 muOJHq9rsFzgyFmxlvDgbSfcmMOy4lHvgYrzdgJUJ3XZ41NsMUXS4dMxloMnFujFn03A/
	 kl/jiSj7rC4IkDjMWvf+lBWohLlnmaVBGPaHcRX8Qf7foBk7jEWE6rLXPzxCqkjSwcUJ9
	 nFN/J9T7SMSmr8MXJBr5BS0t4I2c1Eq9CHaz6t4DVYEq8p3cAvgoxXvqNtqI6E90E/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=pLe84CIjE7JMdWIDedgpqHt9pgQfnSgTl2+qtx9JY6Y=;
	b=bQOqVZ7yuJZf9c6M2Z9on2Ef07qzcVfaFExjj93+W9eflBXYCpNQqW6640KUZf/AO2HU
	 nTGaLg658GrcV/W8o4EpFbFbwS5h+5Zhdl47qtQ68MrN4yWwuK2ktOzEp0QpPWZRd/lqL
	 R3kgcX0j5L8toRGLw2n3RryPokIWP2DwVsovNVBUppAb1LCIeMW/DP6b43YyPx/NFZxjx
	 sRCNF77V7aezPdmAv3yYJjR+i7Okp+hrq30UTFjTwOMvNuMBjSVwnqWQF3+9jk25CE5yY
	 OSY0HZUB+IfD2b5zq7oLls4210q4tPTppPuDl5wuL+OBox8NF/0fjKdE6Rwr8c4d8og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AgtOcpP5;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ACC606A31C
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 15:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05ACC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AgtOcpP5
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49d05d51553so15255075e9.2
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 07:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794324238; x=1794929038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pLe84CIjE7JMdWIDedgpqHt9pgQfnSgTl2+qtx9JY6Y=;
        b=AgtOcpP5YjMSKqp1P7MsDde6yMcdLe0NVbeBgGvYtWXnqJFIOlBh58NMhc8BkEF4+o
         GPH63uhd2P6YWhcmZCrrzoQW+Nlh2xBV0W95YmBAtCK+BUgmhe3XA1inr9/qPsI4HVDO
         5gOhLeh0XpqANBQw7RwPSSNlJd5RPbk8Z0DMYdJQJqKbcaQGbQq2TU7sRirCksD+h25Z
         wdcmXvI5qwMMjlApKD+Il2iHkzzSdbttUbdZMUesdeGZArXTQwt7i98vhWTmA4baC5ju
         NBDeNWkJC18T6vgicjkb8ZPIB7yR+XIaco054qMLh2cA4TqwX3FIJswbDcDv/YQaAzD3
         OozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794324238; x=1794929038;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLe84CIjE7JMdWIDedgpqHt9pgQfnSgTl2+qtx9JY6Y=;
        b=I76omr9xn+AfT3TF3s2Kigy5QrrFPj9kW9iW6U+ee9irYe10CbCrITfUfMQbH+rYH9
         8ezm7/cVS97J9P9l6fYH3Hm+/CsWFz4Zvx7AwtFepU20bB/mtHlik7y5D8U3cGDoL39y
         Ok4sLH2WcQd7F+qn7OwkX1s6mvHEZsyNO1WfgZVt+l38fgAQl1+VTBoQP6c85IWfxiEX
         V43b7RDO8cnpGwkJ3VtSk38+5DRK20/KbYLi0vgsDkDji877RPsAW0RjOHokDcLG93oO
         pjmFRgm25HXHVEFk/sOxRE7Z461V2OuX19zxjsWwO+mhPodLLDpkoGV1vKUejbWnSVSb
         Jg+g==
X-Gm-Message-State: APuU4Z9sB/vDw/7tTAzMbt3YzL21j80YKG+dbD0hbPNZ2CbCMXCvLP0Z
	/JsCi3FDFGA6RKl8Te3TZp58zvmVCdc0oDwonGFA1OpC8CJbBek5EzYLqqjINj2u7QmKisFBJwo
	NUUsLDp0=
X-Gm-Gg: AYBFou0CvviTVwXG2NlNkNfbH55UCgNYuy0AoHmIt4EVWA3Pms1To+3TM+stNvDJ2Cg
	emIyJavFBr/SvwQsgWh9OHMGYfbiwxqZA8a1xE0uyszgQM6SlAJAwuN8xlTXsxPPsp7JEximJHA
	i9S8lQ9tbBvtWwt/zRV+HMs0iGG2viE+MPZkSF84nkfMGbe+D3UHo9CL8HZa+Csh4CK/9LogED5
	r7ruD/RJWSfY5DxrWZfGz/RMCGMyHlMNIdvlm72WsOYQ0P80HxftktdqPPytEZPXDIiiTJ4lA3R
	NuFh0JbScxZbSvE5N6hwCvbXCjJlUCnfBCi9xaijDxx/8OK3SWS4fiCb9BzOJkAC/qnmDAyQ0JG
	cDd7dsO3ppy8CRpJqxI8eGxs8Lli94Nl2DHQIj9nHc1ZGpdPEk76zVoGGCcQJkoX2r8woZAyf4n
	DwuRVtiML0Lkk3r1U0hVNrOU0hAT3aGDcTXEpLsYJDeU+zTXQChgWA+JXY0Hbfz/H8eGCUA9Ybz
	PGyBmn56sv5l1wN0EsoZMjG8CCXiHQbjlt2oAXti62EWIS8D3H44lKBaHFtbexPlqK6Ct8waF4H
	1gW4MavZ86ESYKjn6PrY2vnnJr4tUQlktVSTSmlheCg=
X-Received: by 2002:a05:600c:4452:b0:4a3:59ee:86b with SMTP id 5b1f17b1804b1-4ba0230c98fmr49701535e9.4.1794324238249;
        Tue, 10 Nov 2026 07:23:58 -0800 (PST)
Received: from localhost (109-81-94-245.rct.o2.cz. [109.81.94.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fdac9csm104402665e9.0.2026.11.10.07.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:23:57 -0800 (PST)
Date: Tue, 10 Nov 2026 16:23:56 +0100
From: Michal Hocko <mhocko@suse.com>
To: Hannes Reinecke <hare@suse.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	kernel-security-sentinel@lists.suse.com
Subject: Re: Automated commit blacklisting
Message-ID: <avM3DNYhxxzg_YEg@tiehlicka>
References: <94510397-fef7-4856-a8cf-c9f5d9dd0ed8@suse.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94510397-fef7-4856-a8cf-c9f5d9dd0ed8@suse.com>

On Mon 09-11-26 15:45:17, Hannes Reinecke wrote:
> Hey all,
> 
> apparently there is an automated blacklisting bot running (cf bug#1285635).

Nope, there is no bot making a decision to blacklist a CVE. This is a
result of https://bugzilla.suse.com/show_bug.cgi?id=1285635#c1

> However, there _also_ is another bug referencing
> the same commit (bug#1285636), for which the bot did not do
> a blacklist.

They are not referencing the same commit
Security fix for CVE-2026-98399 bsc#1285636 with CVSS 4.4
= 37f61b71cbc0 ("s390/ipl: Fix NULL deref in dump_reipl without re-IPL parm block") merged v7.3-rc2~29^2~11

Security fix for CVE-2026-98400 bsc#1285635 with CVSS 4.4
= 7f918871112e8e ("s390/ipl: Fix NULL deref in kdump without re-IPL parm block") merged v7.3-rc2~29^2~12

They are part of the same patch series though
$ ./scripts/sha2series 37f61b71cbc0 ./scripts/cve_tools/cve2metadata.sh -s
https://patch.msgid.link/p02-02.g6f5dd41a34f4.ttjpfvt@ub.hpns
Found 2 patches on the ML
Cover: https://patch.msgid.link/c00-02.ttjpfvt@ub.hpns
37f61b71cbc0 ("s390/ipl: Fix NULL deref in dump_reipl without re-IPL parm block") score:4.4 CVE-2026-98399 bsc#1285636
7f918871112e ("s390/ipl: Fix NULL deref in kdump without re-IPL parm block") score:4.4 CVE-2026-98400 bsc#1285635

This happens quite often and we are already working on a solution to
evaluate patch series with multiple CVEs assigned together. We are not
there yet though. Please keep in mind that decision to difference
patches in the series might differ.

Please also note that the information about the patch series is part of
the initial assessment.

HTH
-- 
Michal Hocko
SUSE Labs
