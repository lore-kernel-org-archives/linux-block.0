Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0058.outbound.protection.outlook.com ([104.47.41.58]:47136
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751302AbdASALl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2017 19:11:41 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>
CC: "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [LSF/MM TOPIC] block level event logging for storage media
 management
Date: Thu, 19 Jan 2017 00:11:24 +0000
Message-ID: <1484784670.2838.7.camel@sandisk.com>
References: <6040124E-4928-4FC8-8A52-35115D9CA1DF@fb.com>
In-Reply-To: <6040124E-4928-4FC8-8A52-35115D9CA1DF@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-18 at 23:34 +0000, Song Liu wrote:
> Media health monitoring is very important for large scale distributed sto=
rage systems.=20
> Traditionally, enterprise storage controllers maintain event logs for att=
ached storage
> devices. However, these controller managed logs do not scale well for lar=
ge scale=20
> distributed systems.=20
>=20
> While designing a more flexible and scalable event logging systems, we th=
ink it is better
> to build the log in block layer. Block level event logging covers all maj=
or storage media
> (SCSI, SATA, NVMe), and thus minimizes redundant work for different proto=
cols.=20
>=20
> In this LSF/MM, we would like to discuss the following topics with the co=
mmunity:
>     1. Mechanism for drivers report events (or errors) to block layer.=20
>        Basically, we will need a traceable function for the drivers to re=
port errors=20
>        (most likely right before calling end_request or bio_endio). =20
>  =20
>     2. What mechanism (ftrace, BPF, etc.) is mostly preferred for the eve=
nt logging?
>=20
>     3. How should we categorize different events?
>        Currently, there are existing code that translates ATA error (ata_=
to_sense_error)=20
>        and NVMe error (nvme_trans_status_code) to SCSI sense code. So we =
can=20
>        leverage SCSI Key Code Qualifier for event categorizations.=20
>=20
>     4. Detailed discussions on data structure for event logging.=20
>=20
> We will be able to show a prototype implementation during LSF/MM.=20

I'd like to participate in this discussion.

Bart.=
