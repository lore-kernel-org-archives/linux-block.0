Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4E536606F
	for <linux-block@vger.kernel.org>; Fri,  6 Mar 2026 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772820672; cv=pass; b=HqlOfJvAQmNLSltOMc12urQDe9bpzmv4HfgoJ9H/GUbewhsfMp0Kk35tn0pOc3iUgXiGRAgXvOV+Pgv0OFNw2fBI6F8VfZh7yFiuaF0bzjr3J/6kl2vc7h2P68Gdn4/PJv8SryjIbyO0igi2ELVCFv+A9KNbRNvx67hrD3Q2/+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772820672; c=relaxed/simple;
	bh=qyb599II59ktkQrKEexZcG59uVcx7vIKW6lRRf0loeo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AU6hndM9nP26BfEeWTi2pQBZqbBmHq8ZdtTPwUHtMn08uInLwG54Ke+KmrQn7CLiTUtzcg9WkU3M3HopkaOIS+wILBn/LJ8MTH04zriseret1btOXQB5qD7mW8NlrmMcq20NMZq6GctGeq2rNjAJAEo0JaNTt5DolM+5UQinFKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQkeyT7n; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQkeyT7n"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bdfd129c52so6175728eec.0
        for <linux-block@vger.kernel.org>; Fri, 06 Mar 2026 10:11:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772820670; cv=none;
        d=google.com; s=arc-20240605;
        b=jWMUkyo1fKqcx7cIujrN90WQQ0/aB6jsPyhc2JMHwVS9v+YV6zjP4t9OcJNHzHitbW
         XPjq8UmvbwW3xqJcjDoxFFocWhI/KE5nJ+y2di21TalsL1zIMG2apQxb8xTWll7YRDJN
         3Eri3knIhro+CWYwgwwifKp0bu34+aQnHs2WbcdOzlj7h8A31Gawdxj1zZRrEErDHy8I
         HMwHvQuOmLfAWbMHqo3Ifpb34AAQjgG3uCI/CIyeEsq52APdxXAaPH+wcXR5hSXkjRL7
         2N2QfXYEwRQ/LQGLV2x40MkN99GLIn3URl4HydXN1N5+OXiAmBJ4/6JgDpr3GfJRIcTz
         NZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=BdG5ydXbvl22NG0NGsaDGAE9wamBt6ijjv71z8rwbOY=;
        fh=zTZJB8QMr6TXPkYtaPSWZv3ppR9mP5/uslHHdEdc3Oo=;
        b=O2xhal2OChJdYSpuM40gz1Cx9rTYh06hs55C4VWY0zI1L9CKoJIMu7qK/tTlGtpriS
         RsVQMicpTXkUxFfnPJYL0vF/NcTKCg9zKrGoxViHe+1oyY5E05m4KK2pihu8+eGHBCIi
         C9j2m8dtgWWigsNQS4aBZ9eriyqxvjZuyoPqVG4SWU5nZ4v6iavxHjYBPTtf5HeycI2F
         D/RHVmeBeVadde/32ZjOdTWPxymvRjVjwmeVEUHnecJKedeJxUjPPJDjLxxDCKmnLFuW
         cuIEprzq6OdZDRlfc0fO1o2gwmwF8giy8D02YmPVoOtW47UUb7eWxsCyOfTcsQ2y5J01
         pwSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772820670; x=1773425470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BdG5ydXbvl22NG0NGsaDGAE9wamBt6ijjv71z8rwbOY=;
        b=YQkeyT7nyrQZ8K35wOLhS6F1PJgDM3OLtB69y5nJ3JA1ZxOJlV8yDpNI9dssviAClT
         w5/yBXu37esqMypx2ttpNLS6KYhPfRp1dM+G9O4s9/GLt6kA0FAK6lYGlNPlDzfjkieZ
         axHF3Zx5+RsXhQLsakLHtDrZEyi4hSPimzOccuJlRyq0g6CNpD6BOuEYOLqS2/u4zj4W
         MMrQpKz5pmAsAk0Z+mruLEIlERXJZQmOMr+gKcf28CePkqQU15FknMqIgoqmjRYPTo+t
         rZQjDKEWnii7By+xle0hSMGIxVLOq8tLJ55Zhq7fzJR8KTC8SpjOLYkn67nOaXECrV7U
         3mCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772820670; x=1773425470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdG5ydXbvl22NG0NGsaDGAE9wamBt6ijjv71z8rwbOY=;
        b=WOwg3ZkcJwyga74j5K9t2S1RklmUZ9HPxc363eQsDFIAed23Ej0bos49PUtimSgD7Q
         Ck72tKz9wrt0OnCklf3a7C+GgTxwsspxdpNLNCiQA+bjPBwf1UC20pZLLvw88kAqW3KA
         L33hQSOj/uelBi4pZQMh5rJOndtVUkTppYPIoAKUJ/DzelqPwPj69D5O4eCSmwSe07jA
         ftIs+eCoEPpOLlASKQMlKffU6qRHgMlYTyINKI/MUYhJpMEYCBJNbb/RGIEjDSYgBI5R
         ktHVeoTXyOOKmtf1qPPCfRoQpGjPaiMLw5jpX7IaQp2y5kiOdixoCTTHk7r5R2qehaIn
         dMBA==
X-Gm-Message-State: AOJu0YydokAiQnjMJmin+RnVMu5eoD/wmOMp2KiFmSdIwMliBc46Ii07
	Ssl9LTE5leHGsDuxCzMd3X3O0N9xBcO/BZObgfLhob/NwyababUMPGA3QRAhi4VjKn8mGx+XYSf
	MNdot54XX3Irbr2qzGOz87QCNXuimc2UUc4Xc
X-Gm-Gg: ATEYQzzNelSPCOIaUWZGN7+EFx32IXGbcpeNpzl8Lxwzk+7wfRUX+/VFAtkod0/PAG7
	F9b2Hs/ypk8TBlFJXdnQCHZRpFvMjAv5Aq+MroR20lNTv7NpCpRlQYELbrP9Xxa1q+E/gKiT2Io
	nheZDfsDao94K1hRxQiThDTlkYKdWtmn/gj9ccDzq3lrNhVSLWlV8xsXKGwFkt/NTQ0f38VaThw
	VUa1Ahkb390X1Xto5phGeCOn+N8o6KVb10lvvQegSuhczJyXNizql7xK2ilpFwu6IPLrciRz6fq
	TirBXHLkTA==
X-Received: by 2002:a05:7301:6086:b0:2bd:df29:8ec0 with SMTP id
 5a478bee46e88-2be4dd8249cmr1123493eec.0.1772820670411; Fri, 06 Mar 2026
 10:11:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muthukumar R <muthur@gmail.com>
Date: Fri, 6 Mar 2026 13:10:58 -0500
X-Gm-Features: AaiRm52rP6VNCf90VUZwRBXpL4UCAIoKBhgAoJKBiouob3JqsY2Ew30ayOsIIEA
Message-ID: <CAOnVdK5zgakTz0LTemK13bqigU0Ro+M7w8Pgvcj8gReY1OhavQ@mail.gmail.com>
Subject: Current block dev tree.
To: linux-block@vger.kernel.org
Cc: axboe@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,
It=E2=80=99s been a while and trying to get the current block dev tree (Jen=
=E2=80=99s)  from
git.kernel.dk/linux-block.git but its timing  out.

Is there a new location  that I missed? Please let me know where the
current dev tree is?


Thanks!
