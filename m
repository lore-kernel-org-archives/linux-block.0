Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C33148B5
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185234; cv=none; b=PdxD7XXYkdwyLY8h2vzinsM0GIJWa+9LnHh9QR7Fa7ePoaQVGnUffvKYICqbQAGp7E4XPEjI7gaJCJnLKrq2jz+z0TnfApaaKgdc4KW3pFXiP2FCE6ewlMCUs/Dy+dQg78h1t64yjYeD/vZAviWEXV6mimK+Q/7Pi23uXU9/fCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185234; c=relaxed/simple;
	bh=qrT9BCtX5Q+ZrBSV86ofie64KLKL7GM3W7AojJFifCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtK8V6AXYQrkMfR+/0ktEQFUsuIkMFdQN4uIsQFFaxuC0aav6prGet85sDmXOm8VIPvKFxYnEsBxjmzDTBTi47m7MuBNT0r3WrE2Q1L9yvQ5MVYH5P9q3rVzyHZaR3x4Tk24HCdAN0jq58iVwwR7Q6tv7ilBDQDr3SVhZV6Vleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSYZGuZi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSYZGuZi"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4771b03267bso30611435e9.0
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 07:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762185231; x=1762790031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLey69Q1yRBIRmkA9w/tF6nJaEmvXdViphT1MNeupw4=;
        b=HSYZGuZiIcI0W8S8M894OpH3yfk5w71l42+mebiaC3OAjR+bvqAWD9FzbzDwu8IY8q
         5wyxNEEzI89Aqt17V+goy/gOs6aR4adkVDx1XHOZ9rMfU/c7uMdhxjXo0ABXKGSA3cl1
         4fnWSbywWsDd7WwfUI5AQTIJsJus8C7+frvSNkUeMhSDx4TDN/vlcPAdSoW6IWOPOAvq
         tP5i9W4iKxca1M0NddqZM4uNIhdM+51ZMTAm1hSOk/7ACW1+XOi2pNA2UIutcb2hqeF9
         /r+JOBgkOtBHcOBtNEOzk0yNer5Uz91237F30lKwsZHRFnbr8foaeDwsT4hQzPxDOOmB
         wreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185231; x=1762790031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLey69Q1yRBIRmkA9w/tF6nJaEmvXdViphT1MNeupw4=;
        b=u9uROGjiI6XLAuWEzTZtQoFopTBrDpaQ7fflDzV4Zl9rsviHWdFgzvPknHAVYosJ0s
         71r5OlLbOjs5sPfLHYjW26Ke0tw0OTAttDnOeAtWj+eae5meiGWfn1LcpyPwhZBN0dlZ
         EOtj5GdxE3aHIGH+HpBdsD9mifWfZKcNiUXr5PR1YhzUnGWlStVjsW87ZWynXsx7XP2V
         5gnqTfCSwZwhbn36XfQmVG1yzzxSJIpRKk1s+H8vHGIAtNLZMJx5zhbO9aAuCXnz1euu
         xwPCUiWBRt0v23J2GCnUVZWxXBixAXahRHwX4OK+JkwXaWTrjqbT1u4v7eX5KpWvecIk
         ZOCg==
X-Forwarded-Encrypted: i=1; AJvYcCUoIZAG6/jEfgdAfWiZWCNT8BcPPfCcfBGnm7+qlAYqTw9+oyFID0+yE1v30oR1hNPCUhRuw23f7nDqdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIKXPkUjMboGtsmIzoCJ6A6mThDPVdtkS6yU6KROJZT5rQItMi
	Zs6tK6NyfW7RubjOyhKgn+BIsSWmqbzUUnZWCpON9UosTOT8zfis1Bv2
X-Gm-Gg: ASbGnctvKx1f7p08wwFqwOFSTIQC6rlQli+pYaDmxW2nONvPUc2sCqte3luV5YatK4V
	oX08jDGY1u5VGMeHKtcOFArkOtlK7MKN997KGgarPqqPu1k4FcpWmDB6YTPJbe0ixtfPxIRL+co
	oYBg47kfUXbvZLjNnewWvf1jjk3ExXSn/1g5PbNd8qGsKHd4YPkqjs0F1Z6BZ99Te/wi0/ojR8e
	wqwKnFRgmBcmgCSJ4BI+aBHYVgo5XXzsZqm4zwWZ3n4O7i0qjsd8AJQ9JuQyd9DjKtkHWqsaKTs
	3dUiZEJVQy4NbGpFpu5AT5bpP2gTN9ib82Wsr3Za1H8Fgrd3vCtPmGPHfgRz8+unEVxwF+freiY
	CNTzSvdNEXmsCesYfcI6173ZCWiIGOon94ESs9oQ8y9bKdnvWiogncgsIzC7iyTBmxs5J3EVB
X-Google-Smtp-Source: AGHT+IGy41LT8aj0/Xvj0W53yZvKvDn5c9ABQJxOklSZONmqbPHs8HNDAqrjQAZba3bO5xPU/Rodqg==
X-Received: by 2002:a05:600c:3511:b0:470:bcc4:b07c with SMTP id 5b1f17b1804b1-477308a8f36mr118541675e9.37.1762185230454;
        Mon, 03 Nov 2025 07:53:50 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4773c48de65sm161908635e9.1.2025.11.03.07.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:53:50 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: mpatocka@redhat.com
Cc: Dell.Client.Kernel@dell.com,
	agk@redhat.com,
	brauner@kernel.org,
	dm-devel@lists.linux.dev,
	ebiggers@kernel.org,
	kix@kix.es,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	milan@mazyland.cz,
	msnitzer@redhat.com,
	mzxreary@0pointer.de,
	nphamcs@gmail.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	ryncsn@gmail.com,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] pm-hibernate: flush disk cache when suspending
Date: Mon,  3 Nov 2025 18:53:45 +0300
Message-ID: <20251103155345.1153213-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com>
References: <c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mikulas Patocka <mpatocka@redhat.com>:
> [PATCH 1/2] pm-hibernate: flush disk cache when suspending
> 
> There was reported failure that suspend doesn't work with dm-integrity.
> The reason for the failure is that the suspend code doesn't issue the
> FLUSH bio - the data still sits in the dm-integrity cache and they are
> lost when poweroff happens.

Thank you! I hope I will test this within 2 weeks.

-- 
Askar Safin
