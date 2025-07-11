Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F81B3925;
	Fri, 11 Jul 2025 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224611; cv=none; b=sOHaZ/tXos/luzw7IltKRrt4sATCnI5k/D3C847hP6UoC3WjtzY7loHjg5ute6IQYZeUz4zcexdQjy3hZt2JTiJ931DXMBhbDV4tehnuTf91KFFWOo9THXpca9ZF3cg796PY8DHo2cBIqG813GUKg/6az47iPdeclMWpyz8kNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224611; c=relaxed/simple;
	bh=b3JJD/iuKud6EpAAvwyBJrA+wx1cOSEEm/RZO9GBn6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OpUrsjgvFrD2fWG/p5xZY8vzJVRs353lr8msTrelK5bY1JbtxiJzqNWNIUQZ4MQunYWlbduwVi3arALvuitqihXR2vEeZg+HBw2qo6iqXtOzOFOocbCwuMTtnlP8WhEhNr+BHSzrkfpe/i6uV8eCmj6HrZ6bAB9olm8tI1w0CFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=Bliiw9z0; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="Bliiw9z0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752224587; x=1752829387; i=efault@gmx.de;
	bh=PrmbnWDCiBUDsfzOJoaVMtjQRwntVJqvk+BrLUNF20M=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Bliiw9z0qRELKtwQfKPTOe6AYMX6m0UcLekLvo++kA6eCL3F4HbFJRBjwPFQGsP6
	 ep5nMvVliQex+V2I73cu7CtfQN7xeMcorRnu+cqojIZb+QpbxHR0lKnigYihFQK9n
	 5UcmOIFvd9zbGM0ON7ScnS2W9KAab/E6hrqadbWGh2gsl0ewc9GvJYFmaA3v+CaSo
	 9DfhcLf91xFMMzgWaaJopeqJ/Wwml8WgX6EesUdLvFQas/dT/P8PCBBlXLq+fzWAH
	 m9nSUshekLbU7d/p8vnRyRcw9ePw7l1glpQH87xXV2tN5GrpsugC4N/g5pAroPKLw
	 7wor4OW27A9WjI7h6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.87]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hvR-1uki0C0ioR-013KIe; Fri, 11
 Jul 2025 11:03:07 +0200
Message-ID: <2fdd01857b95b086bcded0a006993e820d3efab0.camel@gmx.de>
Subject: Re: block: lockdep splat with RT config v6.15+
From: Mike Galbraith <efault@gmx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 RT <linux-rt-users@vger.kernel.org>
Date: Fri, 11 Jul 2025 11:03:06 +0200
In-Reply-To: <20250711085906._cTpNNFu@linutronix.de>
References: <7c42fe5a6158445e150e7d63991767e44fc36d3d.camel@decadent.org.uk>
	 <aG6nMhimN1lWKAEP@intel.com> <20250709194443.lkevdn6m@linutronix.de>
	 <aG7MckLkTuzZ5LBe@intel.com>
	 <da51a963b04f0a1b628e80a2c5df72a1609960d1.camel@gmx.de>
	 <aG_hNb-c_m0yfVE4@intel.com>
	 <641d3228244517fd1cfb4a103339e86a222cae2b.camel@gmx.de>
	 <cb6f0eb4abcbae7b0d447b679823b5d537b25b70.camel@gmx.de>
	 <990089f6aaf73d7e3a49d1db1fe677bb575043ac.camel@gmx.de>
	 <20250711085906._cTpNNFu@linutronix.de>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:pOYAltTceemJaatOv5/ZNuxc7bY2et6cJ/Sg4MgwMb6M++d2JlX
 pCEft6S6lktGWSxfbe8/yFXmiv0oGxOfiX//9h9u4SH9rCGGrRDlgxvcro2lAwYgDxORkPG
 nu1h9kN4mBMSEvqVARKWCq0ostYNe5Ti4KVONeeuQauNz4TvORsIrP4juteyHc7WxKrPdBj
 tq4n1+84o132YZkiI0DFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IQSjJysW6dU=;UAhBZQ3CONrfKHKu3RuItenysCd
 g4m45JBCXcdQmGkG27kLfQ31lXS7UpZ66COKttyGJiCsyur68/8AjOUkqletHuIi5NifGKBhd
 GTnjBoBoax3A+s5h4JV4YqpjkZTqkxhqxSprIEWU/tCP6tutn7gvUdQoRuJpSIw5/U1aDQnP1
 0Vn4XY2h/YWRhCHBzVFwmgJJqN9hyMNDWqkTgBD6LURI7kHsx/xmnekxb8+kkOjgVj1NSy621
 XIV2GO31+tM/35mQCQRmjN9rpeIM/Cj4dAIDDuQxiDKBpg3obvHd1cJpw4BlrJaOyGUO/UmTg
 dM2RHD5wWdIZ/rRh8HWdan6HYTTAzuRBpqePblj9tc4wLAjuiu4k04UljAYJAB5p6rkqhntuL
 lFTfKiiVsP3kzsQIMuEvL+q2os0Tn3UvaEAa9/ecr3f/m8NoLHKfOrrYOzBwQxCMmX/8PpcHG
 nDdENQARm31TrWcd2B3Dsvt9TYC2otplbdu907r6nBQMTT3w7NVI3ybCd/YDMIFvAfQSpMyNW
 Qnfw4h7iEalJQj5a2fCUQnisCx/s0OVa1AQz4sTVfuR/PipoaHuHq95KDlg/+LhhWnwIa6L4s
 RDNwkRB23crZiF+avXEFGDEK8gSFeEmhb/L43W+zokOpzlAygg6fvgMEj36DRCiHpzaNutnyJ
 5FS0QoB+iXAVvUmfTxskYG4DUOKNcvYYUVftif0CrsR0rjREkcsIaRkgYnTBdgAY2PS1ax55u
 ok6jUKomLO9bIOBLk4Nl9BoN84PxG1aSk/DqrFkNZHhDbgRLduAngdOzLFCX7bf03BpIiaCyG
 gzR5RPg7JSovIL9tTfr2cLwjxkHFPRWjcaO+wdBiwG/nZH+drTWdNBy8zHrHYr+1nrCFoxn37
 u+jUh8XQSLNRKw9nThk0Tw0thwLyLjWbiMVyPAFH9tUA8Bbx22qraq2BpqZ5EnGSrLianz0kM
 CoX6gDqcskROvAkypFVgBT7klE9wUu8c+LkrmIkEmvIA63elMLXpZSOjaefMgLO6uRgsLPxMW
 agsvV9S1KigYieExClltxXuiRtW+Gjjzi0d4vUrJuCCQ2agaEkp5Yi+mdGtRz/qPVaD3SMi3B
 Rzzdt0kp5Al9oLn1wZliAVR3Ble8RZhyMEqf4fpqn9cXQgI5XvFARYGgbSZsFHDu56tE9SdwB
 cNCWamZ3RGicJ2fvJXaPHMnKqdKa9U9mlfcvxnxSG/vZ2w7EKpsmphDacuqUbLggT4RKGL0H7
 qTPcm1X1AhtgO56MGGQmGbzMJBy/nUM0WTAYN6qjG1sNdeA5cO9oww1SerJuPfHN8w0+2e7pR
 IiM/I/0ARclU6MQIaKbiwrly+IhuPznh3tTcJvHLJAu5TcLIwXuv0Izy3GWo0YsaqIufjcMj4
 e89hNkJaBPma6/TqN7R+4sgQRRDFZiYPqoHghUdgLcGvzXhfiL/hXlTmDaIeuqf8sgYVDUrWA
 AUl2LM4JB8hEv8R9Uz+FudMdt8pSjEPAxDzYlxU2mfBUoPauhrr3SFvREg/a8E7IAU8F4thKf
 FFQ0tX8gt3eTEmP/YK49I97yGSUsi1u/B1lI9pq8Hebchd24oY5H+nOlolFI1MwsN6XBasknU
 a9MQeJbCTu8VAWDSI71w/9Lnhz+LWzWYVX2mO+wyLzwsmYaYRaqlaNelITWJToGseMBt4bws1
 KhWQc5sRRTemq9DqUWzbnvNQ9hQAemkNUb06Ovd0fxqYx/6YDLACRdJE9HxqrNnHkz/knwZf3
 nPUgeuV1goUB4Vi2CemNxhsY2dJscfJ6CPO3USM2mdrZfL/nLm32JM7TOsTKkwSEAPRjcmjeW
 E4MVoNzuBwoyXE1Uv3qxb47md/GXX+PaGnKf3R443dzknFPBsma8lVjRl1153RQvAoRNtfvlx
 Kn824kYqNF/1MjlwHQLiD/4qlObXIQg4XRvB9LVgnkuU6bCrYNDNWrbYX/dggudAm70IXXkE8
 05TV2ttF7YxAsdB2Oh3XJikgcXnTXNVYjlH5qT/+BtH/6dp0u3rHMKdtvcchA8+WwrCsfDiTX
 5U8Kk+g+dlI0NaWxffkicnwMFPk92C3pe/jpzx6yat4sDNWRsRsSoEtDNtLDtxwZDKfL2vvOH
 zLZ79VMoJj881PZfxmmDcLBKjZV9AuM3YLbWutGD59vnmV9b1RANgmxfQV0KHYl7m+/OyXcQN
 4Ix17/S0KvlF5aVIHzj5FxcwJfliUtMgBsulL6maD1saA2ddeMPN30BkAwHo897Pig2dsGbq7
 El37uuLwvJ80x0VZWf+AJzl3a/2XQuwoIxXWVlAGTS6Pa9GBrN+uxs6O8oXcN24htwu+2jb4j
 jdz3ELmXeQDZ15YWasVpl2568cdJLaZ+qvuUoGjGv4SOMvydF1GXfaDfmlS+yXKV7bBuBvzMm
 QUji7k/c9brLV6Hnel0yoCPvMQ8lCJ6dC6L/Sm6O1f+XkLbn4kKCd5/ZmwDiH6DDkWJq6710g
 nIXsVRJuFch+RYzOTH5+6sW6YP4PJpLY7abKLZD14oN548mFlnSWt/xwYHRwUywoiIOJfqPFu
 dgqkyb/oCAAiDbosYZ5ecVW3juOwNaB4S8x0pDxWXWB+wxFayH+HEobJ0eK/T6ibjrdE0cZ2Q
 9C72EB/xJHhpzHR8v38SMjJoJlfk0lS2ETl5ohpymtJFyyTtkg7MtKBPbzpu7JhTphmJK3Z2z
 CsD9LHx2bV6NoJkjHE2aNkB9lxA8QsjNmGgQ2+EScClVPwUttzEeWeAaWmYkq1nfDAxPan5Bh
 CBZkmh0Mji2CwPlAQjPN47fcDk+UdvTuQP6RP9vvhhEsrU5sLzWbknZ28TEVtzZkA0u/9U5vM
 84gbLFv+lsoHLeRrS531pqS53YxUr4eN8j7cgBh9hf/IaUj+Tteqpa5RmepWXfmxml1xsM9M9
 IXLgVUFzjcseuVTRwrywkeMenEquz8IlLpv05yj/dgE3lu7hGx6Y2dVWfs6/yIHg9eEOa9Fqy
 9YeZZ/lrJ/kO9OLjf8ZNfzSxeeHlCF17F/uhm5pcpFMoZSwwVAZu7mvW6/P976Ff2Lclijh1k
 A/tDIbtq7qpdI/rOnGpf+tIHPs5bted9O2N1NfTW+C95nAS920YMa7fLpp42ZuyKuFOI+oKtT
 HxIbLjQrcTUnmrMUvUGPsY1HTFk4botqJYS8cL0kHNShdn+r5K6tu2iUhUEw5GePy5woWX4OC
 I1X442YOBFQj9SkA2Jd6dymUAeD0hZN3jCHitMqZRm/CYLBzj7XMCB5ltQY1kNbakIOPeig56
 ciIWHfbC+64ROu3XJGkDLcz7IiFq62yW864rgdO5UUPWJb3fQlkMB5F7VkGmlPNToPAp5XF0w
 thSDTkz65GC3Z9FN6UaSwYc3PEvyXhYYnKAG5dL6yJd0a9XKnIroVs5OV6cIkm3Qy3DTzQckF
 +ojUJ+6dOB7XRXRsprQFieAXsBLxooYJ9ZHifSR9Y8kUi16hSKeRZDxErCz84d

On Fri, 2025-07-11 at 10:59 +0200, Sebastian Andrzej Siewior wrote:
> On 2025-07-11 10:05:18 [+0200], Mike Galbraith wrote:
> > (was PREEMPT_RT vs i915)
> >=20
> > Ok, the splat below is not new to the 6.16 cycle, seems it landed in
> > the 6.15 cycle, as that also gripes but 6.14 boots clean.
>=20
> I don't remember how you triggered this. Do you happen to know if this
> is RT only or also triggers without the RT bits?

It's CONFIG_PREEMPT_RT dependent. The trigger is just boot for both my
lappy or desktop box.

	-Mike
