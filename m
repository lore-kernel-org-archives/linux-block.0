Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F743D5671
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154887; cv=none; b=UUdZ3/yBB1npM6ngfH9thYWlFYx2yulj5Qg2dLfs8p0NhIN+HuekTKWZP+iEcScvvV3Qhj//QtHJJsiVjo/sfI3Nkd9J6nlOuE1fcJAaB+wKegfJD8s4uGexXw22zn5rC+RUlIBVpPl6KngF1v2wtl0QEWlA5/dcP2/wJ9L8PJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154887; c=relaxed/simple;
	bh=/hy8FBeWAE4EOpXcSa/0jttpvESJx6U1qp3kamiQGfQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rmW7478FhOYmi6UPL8RCSq+CP8IpmD4qej8lAQlpgwxGcBG9FTSgle/FMdTDtYB0QXhqAz0YJkcGBFGr2ZKsXTpgaBwDTOJncOtL0RqSMIghysWxzmCFYHGtOSdE/z3BeccB1SqHmQHrY+YoOaffdoxdmfpOqlRQg/dbAiEz4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=N9iNDvYc; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="N9iNDvYc"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-44cf70de986so1982002fac.0
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784154880; x=1784759680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z6rW6/wwPHYcHhZA3kkcOHo0ftaMm7B3us++lYfFCtE=;
        b=N9iNDvYcIYDxfzkanonrE8c6EZKzI0jxsn1I3QHKMyaT+x36jL9eE6LsXLujD1Hup/
         FJsny43EPYFYAevA3t7mKkiHIpnBXlD4xfuPYEk6rz6cO95srWcHbkdgzuqGLwSxex2O
         6WgtKvqfjinVZ3fl9rD8NZ4Mvj6WaKzEZyBoQmFy82P5AxvNJau39OVG1Geile9LKhxN
         N1FBJNu79TyCfqPMA96X8vfKpOA476kd/ZdhICKK533BU5S2bVqfJO7PBcvwDbfykxWW
         F0YyqCZfTXH0SN1gHvxdqyoSiUO+BVennGegTSpYynS+sfPQOWpIoINiNYixtJiEOMMo
         7YqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154880; x=1784759680;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z6rW6/wwPHYcHhZA3kkcOHo0ftaMm7B3us++lYfFCtE=;
        b=ASJV2HHh5UtFP6FRtSLDM9QAkVfeV89Rbw6a/ccAwrKq8fsKuWB6qqdyN/QWAukI++
         JhSy16iwZW4UTDmm1uGTHMlDuB7Hj9BCo4FeeczUnM/9XDYrSdShfr6Iiwi26HUFyGH6
         HJN4dXygxnKXPikquimSzGgNAvUzUs5RNaue+kjos8rDgbZKSlfgHoR2vswnQ8sIduIc
         ApUZ1e17EItLDJW/GbrtHdGp5I1hxW7qSYVEBUPbzPxuxo9G/UZcJ5o8WI+PdiFI4t4W
         Ne2hE1vbJKXgUPwGsz2HXQLnzwb6VI7lD1ZLBsW+xWfflAcX6Gnybc12B70q2ACqH+OV
         Yt4w==
X-Forwarded-Encrypted: i=1; AHgh+RpZe2EGEI7jlph8C0BEEsXZ1gFxNKRxa83Dc+TswYGTz+NKBo03OQEmT3A8G+KBVkqH7Lhu7gKaHV1jyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4+ljJwOnu7DMbG5Zy3X0kWoVN5F8w+OK2IqWEXePtAYuVNhEG
	5ygYYr6IuZgxOPGoacZIXgjfszuqfVFKGBKdwU1lFMJ/5JpExev0vU/Q85JkZJ5BYi94gztNPBf
	dkvmZALY=
X-Gm-Gg: AfdE7cmqLbDP/Y0mwVt9PkdgDpX0mUwXMl+HMHikBPDAX9J6L0grzUZPXke43IIiAzX
	SgSA026YCH2udRwUEAJzVOyMkBjZkqoFinD6E9k3XbkKiQeMo/aqu5kDzGLQyf0dYqF5T+mgIms
	y1mb7LLivnRIgpP42jZW3JUQCAaTGmahO9yrxhP5Ie8+6id8HmcpdyIZtEaMgOO0Wi4RhPX+B44
	8lfC6m0cL1pQ86Bn2De7l6bmIFNG5UwL0P6uAqmu14y3v6ZnNWDDWNw/S7txBfROV7uOBSFP+gV
	ES93sGAvw3L/ysq0bD82JrC1fAuyEWk46YU99Z4OoqQs0hLvMrujqJhCiIl3KdXX6A5NgTGCK6/
	qjVYo7wWYMWhzSuDLGSD5MxT4vQwta3I/HJNDNgy1uT/iLZbyd56mInIgbWtdAFgZZ2N4FQgrgK
	HtD6+nnliS4gB/R+WKCNY2c7DQlC+FmJJBTbacCpZG1cQCpECpYCkC/q8=
X-Received: by 2002:a05:6870:940b:b0:451:fb50:a594 with SMTP id 586e51a60fabf-4562b55670amr2941174fac.4.1784154880024;
        Wed, 15 Jul 2026 15:34:40 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45200b7b4c5sm14362722fac.10.2026.07.15.15.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:34:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Kees Cook <kees@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Philippe De Muyter <phdm@macqel.be>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260714114806.3761553-1-michael.bommarito@gmail.com>
References: <20260714114806.3761553-1-michael.bommarito@gmail.com>
Subject: Re: [PATCH v2] partitions: aix: bound the lvd scan to one sector
Message-Id: <178415487872.159585.10713819813949285760.b4-ty@b4>
Date: Wed, 15 Jul 2026 16:34:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 14 Jul 2026 07:48:06 -0400, Michael Bommarito wrote:
> aix_partition() reads the logical-volume descriptor array as a single
> sector and then scans it:
> 
> 	if (numlvs && (d = read_part_sector(state, vgda_sector + 1, &sect))) {
> 		struct lvd *p = (struct lvd *)d;
> 		...
> 		for (i = 0; foundlvs < numlvs && i < state->limit; i++) {
> 			lvip[i].pps_per_lv = be16_to_cpu(p[i].num_lps);
> 
> [...]

Applied, thanks!

[1/1] partitions: aix: bound the lvd scan to one sector
      commit: d35e236282992e583ed9c1b7ab52e9ef1b873585

Best regards,
-- 
Jens Axboe



