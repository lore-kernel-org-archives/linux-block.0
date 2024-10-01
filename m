Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF601BFDFE
	for <linux-block@vger.kernel.org>; Tue,  1 Oct 2024 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727827044; cv=none; b=fAdPWnjw1KC9p0EK2VMwnnCXB9FErItl7lqxp7Pa78X1XUeUc5DySHh+jspgA1kaZIWqoMbuzGMv7+DQcbE5XtfWezOL/7W95eF1Z7kA4Rlo/4Ajx8BAk5X7jhQo6l6tHCak7vESQucE7OdRQxFgK7LmptF1jLJ0I0o5IurcBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727827044; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VWYwIkX59BfCIMcz101DgRTG8BMJ8f0pdLqdCBX9YAlN1F9RWgKu3vh0P1JzYcZAi7YlKNcnGM0MxeQBvT33LbnG9gYb9+DbGyTi27bO+DEAFD9EVURA0rlGVpJxQu4m736OOdmNdiL2RIV9r1e2wrop7wAHnaKf+wFY5oWbxQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHNcnhrt; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHNcnhrt"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6db4b602e38so49559117b3.1
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2024 16:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727827042; x=1728431842; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=JHNcnhrtZliw4kbWb0DX9i0Gw3wtKiwktCDAlyuQPlq6o94UOMGurfB8iHI6ZIeXhp
         qswo2+g2eNBLKUNAyaye3ImcDpVNZHafEbsD3XnnTElLexc6krqVPkgBy9brGTM+MYBv
         WWznqMC89AIZdONKTGKs73dL5s3oitTYJ7moIHDBEARPaGqtyHVAm7HDPvaJFWswkxmA
         AHI2C34XUE82zl29YppQ/bb+pAS5i+QYmY7updiP0H0nYm8edUrEOiVpLqfp9iUXydQs
         ujcnCpbQXiXhtLD2JVlTP/8rQg/F+uQllVypxrz5wFO9sibBo1+CzWI/Tx45lCtzAbFW
         MFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727827042; x=1728431842;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=Vt/GwiFWQhoRbMhS54rpdXt9Vs+CXpPc4qGoTwT5dKl9SeOKYqL76qXEUekGrs1PTP
         YBqh5ZnGglyyZ48AITvwDBjAEAUmTcifwryQMtdChHJUeM3w4ccFbS7znRyjJg54DJs6
         WlbdahqY6Ixqjo7BGdsK3Ium6BcW0qwkkvzZLY7XzMphjobO2F6+G3guFA+qOY9BFrlG
         DAa7RofCm1wy4Qh+N6sx0DbNocZyW5wAlb9Cy8WDLoiU/YOwkz/P+GhRK5CVOSobP/DD
         GrnBMtiCvhdlXe7Obt1dRt26jL15kTUJsp7Src35wnwAoCsCwZQCvvyhQt9dTAkCpOG9
         Echw==
X-Gm-Message-State: AOJu0Yzaym1Ds/PIqhCPZrOX5m6skPREKsE7UOcT2NLaiPGGRSz/7IJQ
	m9Rx7fm+4kAJYmRD7ZA6R8G0A4DIITkMZNEM31fX8Tk8t7oyZro+LnVfbfw7c8JyQMLmq3/uLVD
	Ci+51f+kiCyX6xnikvWjk6fto5GKnIg==
X-Google-Smtp-Source: AGHT+IEMsTls5UCJifqYOtiWBMmWqGr2QjmhJoNaqBiJVXdA7meH2kvVJ4Z4lMKb1eB34QswbZW9DZnuPs+5bilBNRY=
X-Received: by 2002:a05:690c:f92:b0:6e2:bcc:bccc with SMTP id
 00721157ae682-6e2a2b728e5mr16740907b3.4.1727827041864; Tue, 01 Oct 2024
 16:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Tue, 1 Oct 2024 16:57:11 -0700
Message-ID: <CACzhbgRk9rzm0b6QdVdMZY-yk13nz+J9Uppt2pktQ3Hj4VBG1g@mail.gmail.com>
Subject: subscribe
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

subscribe
