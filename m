Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2411386DA;
	Wed, 12 Mar 2025 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804500; cv=none; b=KoQcGEV30OF/HTRkh16Nv3BSNJkpGJdWviboLRVT651kPKyIctp13aqZXsKubnzHS1XsOm1QkBHKJBfF5nsAZk3TbG/HpC6CdX2uCG/joHmH3rJrnOoz9jF86nnniYU3lnOukynAFiXVsMZY0SeK5lD8UjKCzpLZc55+iNcmtZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804500; c=relaxed/simple;
	bh=FJD8N5mJ8W2jY4cpgu5C/2VS8ma58SrjmDDNgdHEXyc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=t5rwnPuYzKN5k9JR56fcd4bgDEn3iKymo6hwGo31ap61oQhUZPKg1ohQCeLxsfMztULrPHg6Iz3BGoTKj1OafOUmXRuBtF6lzqnD5qKNsLwCqgHYNXe3iTYWXIGFu2DP0R+rlVbqLp7/dJGScVUii9PvTCbPoQXJci0WiA5HK7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thebergstens.com; spf=pass smtp.mailfrom=thebergstens.com; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thebergstens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thebergstens.com
Received: from jimw8 ([98.97.29.152]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MzQ0y-1sx0on04W0-00quET; Wed, 12 Mar
 2025 19:28:53 +0100
From: "James R. Bergsten" <jim@thebergstens.com>
To: "'Christoph Hellwig'" <hch@infradead.org>,
	"'Matthew Wilcox'" <willy@infradead.org>
Cc: "'Hannes Reinecke'" <hare@suse.de>,
	"'Vlastimil Babka'" <vbabka@suse.cz>,
	"'Hannes Reinecke'" <hare@suse.com>,
	"'Boris Pismenny'" <borisp@nvidia.com>,
	"'John Fastabend'" <john.fastabend@gmail.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Sagi Grimberg'" <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>,
	<linux-mm@kvack.org>,
	"'Harry Yoo'" <harry.yoo@oracle.com>,
	<netdev@vger.kernel.org>
References: <Z8cm5bVJsbskj4kC@casper.infradead.org> <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com> <Z8cv9VKka2KBnBKV@casper.infradead.org> <Z8dA8l1NR-xmFWyq@casper.infradead.org> <d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de> <27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz> <f53b1403-3afd-43ff-a784-bdd22e3d24f8@suse.com> <d6e65c4c-a575-4389-a801-2ba40e1d25e1@suse.cz> <7439cb2f-6a97-494b-aa10-e9bebb218b58@suse.de> <Z8iTzPRieLB7Ee-9@casper.infradead.org> <Z9Gjnl5tfpY7xgea@infradead.org>
In-Reply-To: <Z9Gjnl5tfpY7xgea@infradead.org>
Subject: RE: Networking people smell funny and make poor life choices
Date: Wed, 12 Mar 2025 11:28:50 -0700
Message-ID: <052801db937c$9bbf12a0$d33d37e0$@thebergstens.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
thread-index: AQI2rUWeLygajSlNpi7nOHx73cja5QH+C8IvAd0w/QUCBlqL4QM6XMyIAn2avhICzfEg4wKgxvSGAjQyxh8Ce7EXuQFi0EC+sgC+5wA=
Content-Language: en-us
X-Provags-ID: V03:K1:dcMVW0pDz5E1JPOonU9qWaZvIh+IDuHLVFneVIlFdETc33dVveN
 co1twA9Ugo5PZKV/k+r4WR/2ZVc4wvMXZO6XGkeFi3qR8cm4kSN7Er9rDAQQn2OpKfUQekK
 1XVIeA/RxxBoaSPZ77QBYg2hW+h8FjKLg4otGWhoiv6MVVBL+FK7MuMf8u/91uNgJDY+vS8
 efdi4I1cmyyDRPbTMS6NQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KZPl9mMPvvU=;1Yw6Wu2aEXYnHxm+bTS2dL9L4Na
 81ZO7+pSBnkZhaJVSQ/iaQgeBN8ZxvRVOqpOhckD5bJq752PKYbuCmRuTzgvX0WQuSSDAzqLn
 ifMmKVPEX3X81FsYNdl3NV0cInL0DwysOLnxgnIiFzgitPHm3WB4Iu4M4bEZnj0Y6F6EHGXTq
 83jR6CPJtZ28K/x4LB/DVbfajWpGMHO+j5Nm+/k91tj4LzKcmLItIGmH0J/Q5sgKiSbt5NW+N
 wZ0RmSByqLIFcIyWpg0/5tS1MDgMA4tJ6L5zWCRJP052jv/8nTxaiR5frpcpZDJoS3KN41H/9
 6seazDRjUYduvUlJZFaTHJyjtFeM53fIbRa6ST7JnNup+eb3d9K3cSXaznt7IB2kXYUDJHs40
 sFhI9L91HFa+aXTgTQiaAFi4QpVqYFQ2puqnsYY1C3hANZzXelqYNxy6t+zqsi8+GTZTXgbwJ
 cMDa0P5Hxf61zyUsmHplnZqZA3Ce0+AYbBRH5JGLG1343MKQFeynzGN/x6O7zD+dh2nyLZwxn
 zhvrk/909xIuwAfW+pVxPQfvXavZngsTZeu9kOUmXevbGpll7xPnS8Pbv3L1IEdjYgue1KOUS
 8HC6yPsLpnoQe4UfPnXjiciYSbcADz8s5VQU9wGalnN6zBUu/EMCrjhSbeiwqOJvyHisgYoGN
 UYXMkbJpOpIb6b06u9Dr2UFPirDKxH1RePHGvoU6wUXsd8GTTr2Zc2bX8WfHmfF40O7CrwKHt
 fuholSsswMOyu2n7b+AEjqxnoyHFs1ynjb4lSkS8d6BfshYMeVstoVOYoPkOcvMxbfjfGpumi
 KpKhZVHUnTbcKgs5PQass4YNb9rR337YtaHlvaHYUeORp4uUDhz1Jx0+QZRz2Qr7wn1D7eRiX
 H2jCUuqyFg0bM49hsXs4ZDmf5pXJ+T9ZjNG0kw/xOToPxED/tGJTUlIsEW76e4MIgdV+TXBbu
 jtLfNWm9fJWlyReA/ARjI/BNgXz4631Ob3nBOf7lufAbEMH6gSfAWqD9qp+lDCV5AWp+jsgPJ
 mT28bBzFKzjVY2qTSYZR1c/pZ+ATrB0hfdXP4Q4JjjS9CrbKmgjG0Ah7zhtAhasH9rGbgBzJr
 BM8azdb6RGeHhqV0K0cSYnOC+z6h4HoGUYPe5ZH74VkU8DoBIxI1hgjGgOpQSPx6NYn9r1HZA
 JSPVnWYxUlayvm0daPHt9C78x5TTNNJBTBmvlSBAnb86iTmlULepqesJ7QOLZ/RZarBypQtdV
 pdBYP58Jbprk8K82h4oE2APH5H3MPeEiKSxjRxSzszcWjtd4yJlr/NQxWzMOiWVqtb5tpps9d
 4jMgbkkVlKjO/TEJQJHXQjF7fiwnwtqEY1Ks2Qj5ahmMUl9m1oCOC7I2kyyhr2x7fRHltdhaT
 6TggJPEUeT1Ja7CA==

OK another "unnecessary" old-timer storage/network story/disruption to =
your otherwise relevant discussions (thank the subject line). If you're =
too busy, just don't read it. =F0=9F=98=8A

Around 1985, Gene Amdahl founded a company called Andor. Its original =
purpose (as was with everything Gene did) was to build the smallest =
plug-compatible mainframe.  When it was designed, someone noted it had =
no physical room for the humongous "Bus and Tag" cables needed for =
peripherals, so Gene raised a bit more money and started a storage =
project too.

When the Loma Prieta earthquake happened in 1989, PG&E, the local =
utility, lost the datacenter containing all of the information needed to =
repair their utilities, so the service people had to do this from =
memory.  The Public Utilities Commission didn't find this terribly =
funny, so they said PG&E had to create a second datacenter out of the =
area immediately and have backups there within about 24 hours, shorter =
as time went on.  So, they shut down the primary site every night, =
dumped to tape, then drove it up to Sacramento where these were =
restored.  They named this CTAM for "Chevy Truck Access Method."

Somehow Gene and friends heard about this and, as they already had a =
processor, device simulation and devices, if they added some sort of =
networking interface, they could have a local unit and a remote unit =
doing this backup, eliminating the truck.  BTW the "front end" storage =
group all came from Memorex.  The "back end" group mostly from Amdahl.

This actually (somewhat) worked, and a couple of units were installed in =
beta sites.  Sadly, Gene ran out of money (or at least didn't accept the =
terms offered) and buggered off to start yet another mainframe company =
which never shipped anything.

I was the last Engineering VP at Andor, so when it folded, I grabbed a =
few of the people and started a similar company but for the open systems =
market instead.  We named it "Ark" at my wife's suggestion as was like =
Noah's Ark - "disaster recovery" and "two of everything."  We mostly =
bootstrapped, did ship product, and were acquired by LSI Logic who were =
getting beaten around the head as EMC had a remote solution, but LSI =
didn't. I got about a dozen US Patents Issued and enough money to =
finally buy a house in Silicon Valley.

Our (SCSI-based) device had front end ports for the host(s), back-end =
ones for the devices, and side ones for the networking.  Lots of =
features, some you folks are only doing recently.  Looked like devices =
to hosts, hosts to devices.

Anyway, the point of all of this is that when we sold it to customers, =
the storage people looked at the network ports with confusion and dismay =
(some hadn't even ordered the network lines and caused months of delay), =
while the network people looked at the device ports as if they were full =
of Tasmanian devils.

Turned out, both network and storage expertise were very rare =
commodities.  This was largely why most iSCSI startups failed, they =
either did a storage product or a networking product. We pilled this off =
because I am stupid but stubborn and wrote the RTOS myself (Linux was in =
its infancy and the other RTOS's sucked).  Seemed a good idea at the =
time.  Have white papers online if anybody is interested.

So, networking people may smell funny, but to them storage people come =
from another galaxy.  Working in this industry at all could be =
considered a poor life choice but that's for another time.

Sorry. You can go back to work now.
Jim B

-----Original Message-----
From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> On Behalf Of =
Christoph Hellwig
Sent: Wednesday, March 12, 2025 8:09 AM
To: Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>; Vlastimil Babka <vbabka@suse.cz>; =
Hannes Reinecke <hare@suse.com>; Boris Pismenny <borisp@nvidia.com>; =
John Fastabend <john.fastabend@gmail.com>; Jakub Kicinski =
<kuba@kernel.org>; Sagi Grimberg <sagi@grimberg.me>; =
linux-nvme@lists.infradead.org; linux-block@vger.kernel.org; =
linux-mm@kvack.org; Harry Yoo <harry.yoo@oracle.com>; =
netdev@vger.kernel.org
Subject: Re: Networking people smell funny and make poor life choices

On Wed, Mar 05, 2025 at 06:11:24PM +0000, Matthew Wilcox wrote:
> Networking needs to follow block's lead and STOP GETTING REFCOUNTS ON=20
> PAGES.

The block layer never took references on pages.  The direct I/O helpers =
that just happened to set in block/ did hold references and abused some =
field in the bio for it (and still do for the pinning), but the =
reference was (and the pin now is) owned by the submitter.

The block layer model has always been that the submitter needs to ensure =
memory stays allocated until the I/O has completed.  Which IMHO is the =
only sane model for dealing with memory lifetimes vs I/O, and something =
networking absolutely should follow.



