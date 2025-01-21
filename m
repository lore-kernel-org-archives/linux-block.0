Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0A1ABED7
	for <linux-block@vger.kernel.org>; Tue, 21 Jan 2025 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737458239; cv=none; b=pHdDaWnRXMsuFW/6x1XtRYr+GK9Jusa6iEh2kOxGtd2cVP9joSBanoyfV6l2l4FXUPhEuSxgJ8wUkZ6qms0P7ovE6RZVurYnKBg1dQwx9CTBTyhbNpE44ddnMqsrL1toLzP7B2VD1KxetrBNPGY3EBHKfuZYyCCkMCtxDoW+ajM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737458239; c=relaxed/simple;
	bh=JFIvJoLbqnsk56WLZwpkJZdotEUtlP76QNHuvV65C94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PqyGarICokrTT6fcYFYKOQGiQzXagScfTxTudSFnTTwEB4owmxBI6xO6TDp0bxl/lXDQXms+/6X9giL3/4faF9dOBm5eEA9yYpSOQ9766l77+1SisR6RfvV6FCtel0QHwVFb3kEnbN2iCFXgPcnWqapZDJiAHa5R1mZ6PO448j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YakILNdm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YakILNdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21230C4CEDF;
	Tue, 21 Jan 2025 11:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737458238;
	bh=JFIvJoLbqnsk56WLZwpkJZdotEUtlP76QNHuvV65C94=;
	h=From:To:Cc:Subject:Date:From;
	b=YakILNdmh8xMjaNwio7vPGCcyFsLzTGMmSrjWJniNVR9DQh/NroQrz65Kj33l2pcA
	 JCMwvyq5Xe+S0uBZihf75vpJAFTZckXC80vtwvbNjKpRjKGbkI6lSS7ZoLBBDtDT5w
	 +9XpKU6xAODdq8K0XcopwRTfETSyFs2f+oqkkoh43hEuyXVw1feyCmvJcbjC53J/e9
	 Eap5Xt+2XItEpOh2eJztAIlkv9iv0accmEF0pfEklEHGR3zVnF9eSaN5sRil/T1QQU
	 EKTbm+zHuwYuksj2mioNG+QCia6oPHt3QfK+hgEvGNdK0BImDUqkASh4jH341kE/26
	 jrBl6pNCzSApw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>,
	"Matthew Wilcox" <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [LSF/MM/BPF TOPIC] Rust block layer abstractions and benchmark
 strategies
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 21 Jan 2025 12:13:48 +0100
Message-ID: <871pwwctcj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I All,

I would like to propose that we have a session on Rust in the block
layer again this year. Specifically I would like to discuss some rather
puzzling results I observe when I benchmark the C and Rust null block
drivers. I did a write up of the challenges I face at [1]. The
observations are not tied to rust, they also manifest in the C driver.

Being able to consistently benchmark performance of the null block
driver is rather important in terms of validating Rust for use in the
block layer. I would hope to be able to collect some feedback on these
issues during a session.

If time permits, I would like to give a status update on the efforts of
building a feature complete null block driver in Rust. I will send
additional patches that enable memory backed devices and timer
completions before the Summit. Most of the patches have been ready for a
while, but they are pending merge of dependencies (xarray, hrtimer,
module_params).

If anyone is interested, I would make myself available for deep dives on
the Rust block layer code base, 1:1 or tutorial style. We (the Rust
kernel hackers) have had some good experiences with these kinds of
sessions in other subsystems.


Best regards,
Andreas Hindborg


[1] https://metaspace.github.io/2024/12/02/problems-in-benchmark-land.html

