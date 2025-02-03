Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0507B20ADD9
	for <linux-block@vger.kernel.org>; Mon,  3 Feb 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592797; cv=none; b=MMLe1as7ChQbT3NjnDX/j7bWiOjl/Hq8aenGU+XxuNueg1mYPx8us6L6kM/yk8J35TRCbSQ8Fibkzkq/xHbkpSQH4GMhyGwP1UvjFjWnlPwiXuzmPhCPvTi+cCWevhtMD4LTY2wLbcEBr+WQMTIGYRau1Jg+V4Lx9usMlw/fPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592797; c=relaxed/simple;
	bh=Tj7tRy4kZnsxFzQuBtc04+Ahrz10XdqH0zrjX5oVM6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRHnRfRi751IoFETna6CrmTjzQUHv8HpBiweuYPr2xUc+6TU6s9o/GKeZ4WmjaZbENgn/XaHFGNAeuZYQ1NgLfhMt9lBkUOsUyrNqx9u1vkm/TfF9tRixWFrduGuEzgL83YBuSQOqNHYdELaGfEg/8zKn/rFKxdwIds4n1dez+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AhHsSeis; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AhHsSeis"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab34a170526so705022866b.0
        for <linux-block@vger.kernel.org>; Mon, 03 Feb 2025 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738592793; x=1739197593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wApwa+Vg7pEhvhJZMOtchLW1Qtniq1LAppbarYJzbvQ=;
        b=AhHsSeisaNRxfF5kpEuWH/NuGkEEpv1vnTj7ov8dvc4SOqrwanUdq0cerpIrAIY5KO
         e0xLN3NncTQKdHp+2y51NgGmv9ulwc6s6YlQvvC8sEwYzXjrmDPfW1P5sJZJVDo2DO7a
         6Lu7iex/hWVl/LNtRHc9nk1a6ySPHTG1l0ZTCGB9wcC1cOHKHvB92C8kPHmpY1ukj9la
         tpeIMaAJAJis7ibRRLXp8njUjDeCMVKXbSKJVW26O/Tr+nSQrg8bmJLV9r5TKEVm9HkD
         0sdyYVw94J5FrQwbw/TXiWME1NugDiPTG57lSyJ2gwt/zJu1Q3tSraQUpYQTCABsq4U6
         osOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738592793; x=1739197593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wApwa+Vg7pEhvhJZMOtchLW1Qtniq1LAppbarYJzbvQ=;
        b=bfdtdHmt5Aw259S4FBTLQejffURkElKgy5SgotjS4ztPJFeJYAQ8pOJOJRhtjOfr7t
         tFzUhMrXYV4jxMOtCJjPJN/x9itKvI+5SG9nsKk59vZJOsRFrqwwrJWhIm61TL9g5LqE
         oPgyI/mjmHrev30jd4cnnlHWyxKiSQZiNSeEZ3TSagvi4evmM0CrOk0VcLE0O6JCOA0t
         pQ0tt52m87zTms5Kfa52yJk50L6aDKbIsPIa8rpMB8KpqHpwO0sNf+Jd6tEU/tig6XGz
         OUBbPi0jeYUzdG76B7R/ZCGkryVuXas/QiutSva7yFfKGv2ChNZYFeu9h2uWPLehGMlh
         8RaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1ulPQGhwnKeDqLzw5trP+o14hEdpqm4PnCke2uIYCt4KObKzfs3/Qwb+XxkPkdLU0ZmGGbLvJ9gvZ2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgMopX213TUInBA/5SPqyIHHjF4EooXOT4jHPBoz6/ZhMceRgy
	DUyXyL8rKfWdSl9qsUrSpDm4I/K5neD1goa7uA/n6VUEvlzixdSSltXBy3/+JLA=
X-Gm-Gg: ASbGncuOc0yB3x1DfKvQQvKfGIaeCMrpQLLVwidok6Ra2baRkKbeCW2qH9Gx5z+/Vn3
	U/hewdyCxopPsTJDJmHlSOUsbtDoETolh2PIKtoYyx1CKwixfUbVORA3HlTLUiXb9jvsMmmg4vY
	1E+9LflXeBp3hgpQa9EALSXaK9P0/PC+gOyUKoW9CFK1gdDL+UsK2cPN/NGfGcOxFFzUj8j/+uH
	tZbIrj60B5BawQKyG+WEq/lr0PhI//RJo57L8d5H7Pp/NIc6WjUs67JUAPWxaMTInsTLhT6IwtG
	K79zgg==
X-Google-Smtp-Source: AGHT+IEMvqFtWMQcGcbew8g5CbtS87OK4kOUrbaUT5fxc6WJnZS+Qe69TNruF9V9SFX0gjEEIeYYSg==
X-Received: by 2002:a17:907:6eab:b0:ab2:ea29:a2 with SMTP id a640c23a62f3a-ab6cfe11e85mr2509321666b.48.1738592793317;
        Mon, 03 Feb 2025 06:26:33 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab706ce9a53sm509134266b.72.2025.02.03.06.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 06:26:33 -0800 (PST)
Date: Mon, 3 Feb 2025 15:26:32 +0100
From: Michal Hocko <mhocko@suse.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: REMINDER - LSF/MM/BPF: 2025: Call for Proposals
Message-ID: <Z6DSGOsqjw1ahIYi@tiehlicka>
References: <Z4pwZkf3px21OVJm@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4pwZkf3px21OVJm@tiehlicka>

On Fri 17-01-25 15:59:51, Michal Hocko wrote:
> Hi,
> this is a friendly reminder for LSF/MM/BPF Call for proposals - you can
> find the original announcement here: https://lore.kernel.org/all/Z1wQcKKw14iei0Va@tiehlicka/T/#u.
> 
> Please also note you need to fill out the following Google form to
> request attendance and suggest any topics for discussion:
> 
>           https://forms.gle/xXvQicSFeFKjayxB9
> 
> The deadline to do that is Feb 1st!

The deadline has passed but if you forgot or this slipped through then
no worries you can still apply but please do so ASAP. We are going
through all applications these days and will try to send invitations
ASAP so that people can start planning their travel.

Let me also remind that all the topics that are to be scheduled should
be posted to the mailing list (CCing track specific and lsf-pc mailing
lists). 

Let us know if you have any questions!

Thanks!
-- 
Michal Hocko
SUSE Labs
