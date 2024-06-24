Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4513AA39
	for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229510; cv=none; b=OrBEoGLmLrMP3QHQfTYXTU2wtcxclon30VrZDuJjaGhfJUiYv9trmO7x9dCG+bMxd8TQ05Rb1fttpzkQwhbycDYc06+Bn9H/iZq+a88rw2/FnwRI0eqDinwObnklSeXYYAy0shDOz+OwV9If8HwKz8CkWOxliPxBvOzaxpkG/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229510; c=relaxed/simple;
	bh=ZTb6ItNVRUVXB0JKvtftUqyzvS/9Wc86rHio5MZRE5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uw3NgWA988qL4wqM67Y4eYwLoaSgdoYrJ36J+2EHHSHERiwbrvFjoGBduh+KntFSsA1srDJSvwB0r3P4lC/Ox1s9TlksZVxAuJmeP12KW9bn1Fr4A0VSarilCaX+cIA73U1pwUVAyT82WxCrP8M2t7dQAEpARxe3mXxVXTKKjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aTbeZvdZ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aTbeZvdZ"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso46237421fa.1
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 04:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719229507; x=1719834307; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Olwpy3S2NO7dozWXBkNeO0Wjc6p2uaDnBhKTeSGxqpk=;
        b=aTbeZvdZuiF8zAh50H0zbLHSOv6jQUWvGX1TzVAVstHG5jLLV1rNW0S1+I+Lni/edx
         oFS9Xwsq9JqiUglu0vrG5b4Xlh7q+dOAt6JodyymlDMzuHmkLjxr8brFY+xEf1WZ9nmq
         BqQ6Lv5HK10LIZaqpKyxYnHmOFTdjh0EYq12Lei05NCTvRVrf0y3JMKo7BsoS2o0laAw
         UJLdawVp6OtXFZznpBrm4LP6fxsxwcK91zgtLn2DmXXl5WIzd5PezVHBkVQJw2MmCM5R
         PqbBGfuvrsx8uBPFFqjBPfT81JKZacoCp+k2PrJ7t7MT24OiYActbD1uxTrkiIWDFxZD
         d62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719229507; x=1719834307;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Olwpy3S2NO7dozWXBkNeO0Wjc6p2uaDnBhKTeSGxqpk=;
        b=Q7K0pMYOKM+RHUM3Gx7PxrjQR2lOqY3gzxyfa1EK2zIOgW9F8hwHNZBtV6HUF0MeNw
         ue8LcX1CyZmidkfZ2f6XtWq6JH0qhMaOIBgwZI0ddut75omDyjtw/cPgrVk2EyAIPUwZ
         3+r3Rdlv7X1AsDVuFy8Z3nyYLajEz0n3HXhTMCiXN5IFORLg+7woq2Ho1VKvI/ALgmvd
         NWA+q4TlUeSFzvRZMgvWdtGFNxhJBLdiH+E+ghY4/COPdWOtw6yAR6S0Y/GEnQos2xvI
         CxIc7x8jUXGSQ4BM83C3QDLy64NwSQGP1vdfDyHrmSuWscz2d7m8Qb+4+RtKWZO1Hwh5
         ZpWg==
X-Gm-Message-State: AOJu0YwBpaFYpfGmplpJYgX3JNcflmbytxXIalY+zDu5bwYgerOkMTQR
	xEVEeq/GwM2DZDHvI9jHMEyc40N48WdQW83ufajNR+aNj/TwZt/tJCF5u1sVh2o=
X-Google-Smtp-Source: AGHT+IFsOq7RvpS4DTLa5t33aUT4eiJQaXEezbXtvZjKsdrtYyXNMldiri2DeYMRY7GZoSW4pmitGg==
X-Received: by 2002:a2e:9dd8:0:b0:2ec:4fc3:a8c8 with SMTP id 38308e7fff4ca-2ec59312e0fmr32546011fa.0.1719229506433;
        Mon, 24 Jun 2024 04:45:06 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5c97sm60893015ad.125.2024.06.24.04.45.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2024 04:45:06 -0700 (PDT)
Date: Mon, 24 Jun 2024 19:45:01 +0800
From: joeyli <jlee@suse.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-block@vger.kernel.org, Chun-Yi Lee <joeyli.kernel@gmail.com>,
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
	Kirill Korotaev <dev@openvz.org>, Nicolai Stange <nstange@suse.com>,
	Pavel Emelianov <xemul@openvz.org>
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <20240624114501.GK7611@linux-l9pv.suse>
References: <20240624064418.27043-1-jlee@suse.com>
 <e44297c0-f45a-4753-8316-c6b74190a440@web.de>
 <20240624110449.GJ7611@linux-l9pv.suse>
 <8d076c38-f5d0-477b-9b9b-bceee3e2fec4@web.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d076c38-f5d0-477b-9b9b-bceee3e2fec4@web.de>
User-Agent: Mutt/1.11.4 (2019-03-13)

On Mon, Jun 24, 2024 at 01:28:54PM +0200, Markus Elfring wrote:
> >> Please reconsider the version identification in this patch subject once more.
> >>
> >>
> >> …
> >>> ---
> >>>
> >>> v2:
> >>> - Improve patch description
> >> …
> >>
> >> How many patch variations were discussed and reviewed in the meantime?
> >>
> >
> > Only v2. I sent v2 patch again because nobody response my code in patch.
> > But I still want to grap comments for my code.
> 
> How does such a feedback fit to my previous patch review?
> https://lore.kernel.org/r/e8331545-d261-44af-b500-93b90d77d8b7@web.de/
> https://lkml.org/lkml/2024/5/14/551
>

I want to collect comment of my code in patch then send next version.

Joey Lee 
