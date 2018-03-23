Return-Path: <linux-scsi-owner@vger.kernel.org>
MIME-Version: 1.0
From: Tim Walker <tim.t.walker@seagate.com>
Date: Fri, 23 Mar 2018 08:57:12 -0600
Message-ID: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
Subject: Multi-Actuator SAS HDD First Look
To: linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Seagate announced their split actuator SAS drive, which will probably
require some kernel changes for full support. It's targeted at cloud
provider JBODs and RAID.

Here are some of the drive's architectural points. Since the two LUNs
share many common components (e.g. spindle) Seagate allocated some
SCSI operations to be LUN specific and some to affect the entire
device, that is, both LUNs.

1. Two LUNs, 0 & 1, each with independent lba space, and each
connected to an independent read channel, actuator, and set of heads.
2. Each actuator addresses 1/2 of the media - no media is shared
across the actuators. They seek independently.
3. One World Wide Name (WWN) is assigned to the port for device
address. Each Logical Unit has a separate World Wide Name for
identification in VPD page.
4. 128 deep command queue, shared across both LUNs
5. Each LUN can pull commands from the queue independently, so they
can implement their own sorting and optimization.
6. Ordered tag attribute causes the command to be ordered across both
Logical Units
7. Head of Queue attribute causes the command to be ordered with
respect to a single Logical Unit
8. Mode pages are device-based (shared across both Logical Units)
9. Log pages are device-based.
10. Inquiry VPD pages (with minor exceptions) are device based.
11. Device health features (SMART, etc) are device based

Seagate wants the multi-actuator design to integrate into the stack as
painlessly as possible.The interface design is still in the early
stages, so I am gathering requirements and recommendations, and also
providing any information necessary to help scope integrating a
multi-LUN device into the MQ stack. So, I am soliciting any pertinent
feedback including:

1. Painful incompatibilities between the Seagate proposal and current
MQ architecture
2. Linux changes needed
3. Drive interface changes needed
4. Anything else I may have overlooked

Please feel free to send any questions or comments.

Tim Walker
Product Design Systems Engineering, Seagate Technology
(303) 775-3770
