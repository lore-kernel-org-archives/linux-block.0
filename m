Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33242 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdAUFqy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Jan 2017 00:46:54 -0500
Received: by mail-ua0-f193.google.com with SMTP id d5so9263981uag.0
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2017 21:46:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6040124E-4928-4FC8-8A52-35115D9CA1DF@fb.com>
References: <6040124E-4928-4FC8-8A52-35115D9CA1DF@fb.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 20 Jan 2017 21:46:52 -0800
Message-ID: <CAA9_cmd_XMbw_26ePCSWLxP9PoTn36n8sO5buE2iTCoPnK+CHg@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] block level event logging for storage media management
To: Song Liu <songliubraving@fb.com>
Cc: "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>, Jens Axboe <axboe@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 18, 2017 at 3:34 PM, Song Liu <songliubraving@fb.com> wrote:
>
> Media health monitoring is very important for large scale distributed storage systems.
> Traditionally, enterprise storage controllers maintain event logs for attached storage
> devices. However, these controller managed logs do not scale well for large scale
> distributed systems.
>
> While designing a more flexible and scalable event logging systems, we think it is better
> to build the log in block layer. Block level event logging covers all major storage media
> (SCSI, SATA, NVMe), and thus minimizes redundant work for different protocols.
>
> In this LSF/MM, we would like to discuss the following topics with the community:
>     1. Mechanism for drivers report events (or errors) to block layer.
>        Basically, we will need a traceable function for the drivers to report errors
>        (most likely right before calling end_request or bio_endio).
>
>     2. What mechanism (ftrace, BPF, etc.) is mostly preferred for the event logging?
>
>     3. How should we categorize different events?
>        Currently, there are existing code that translates ATA error (ata_to_sense_error)
>        and NVMe error (nvme_trans_status_code) to SCSI sense code. So we can
>        leverage SCSI Key Code Qualifier for event categorizations.
>
>     4. Detailed discussions on data structure for event logging.
>
> We will be able to show a prototype implementation during LSF/MM.

Hi Song,

How is this distinct from tracking a badblocks list?

I'm interested in this topic since we have both media error reporting
/ scrubbing for nvdimms as well "SMART" media health retrieval
commands.
